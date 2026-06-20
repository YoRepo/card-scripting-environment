--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: A-突击核  (ID: 30012506)
-- Type: Monster / Effect / Union
-- Attribute: LIGHT
-- Race: Machine
-- Level 4
-- ATK 1900 | DEF 200
--
-- Effect Text:
-- ①：1回合1次，可以把1个以下效果发动。
-- ●以自己场上1只机械族·光属性怪兽为对象，把这张卡当作装备魔法卡使用来装备。装备怪兽被战斗·效果破坏的场合，作为代替把这张卡破坏。
-- ●装备状态的这张卡特殊召唤。
-- ②：装备怪兽不受其他的对方怪兽的效果影响。
-- ③：这张卡从场上送去墓地的场合才能发动。自己墓地1只其他的同盟怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--A－アサルト・コア
function c30012506.initial_effect(c)
	aux.EnableUnionAttribute(c,c30012506.filter)
	--immune
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_IMMUNE_EFFECT)
	e4:SetValue(c30012506.efilter)
	c:RegisterEffect(e4)
	--to hand
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_TOHAND)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetProperty(EFFECT_FLAG_DELAY)
	e5:SetCode(EVENT_TO_GRAVE)
	e5:SetCondition(c30012506.thcon)
	e5:SetTarget(c30012506.thtg)
	e5:SetOperation(c30012506.thop)
	c:RegisterEffect(e5)
end
c30012506.has_text_type=TYPE_UNION
function c30012506.filter(c)
	return c:IsRace(RACE_MACHINE) and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c30012506.efilter(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer() and te:GetOwner()~=e:GetOwner()
		and te:IsActiveType(TYPE_MONSTER)
end
function c30012506.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c30012506.thfilter(c)
	return c:IsType(TYPE_UNION) and c:IsAbleToHand()
end
function c30012506.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c30012506.thfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c30012506.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c30012506.thfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
