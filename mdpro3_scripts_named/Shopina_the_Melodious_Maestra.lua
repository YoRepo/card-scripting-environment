--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 幻奏的音姬 殊荣之弗朗索瓦  (ID: 5908650)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 7
-- ATK 2300 | DEF 1700
-- Setcode: 4251
--
-- Effect Text:
-- 这张卡的效果发动的回合，自己不能把光属性以外的怪兽的效果发动。
-- ①：1回合1次，以自己墓地1只天使族·光属性怪兽为对象才能发动。那只怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--幻奏の音姫ローリイット・フランソワ
function c5908650.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(5908650,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetCost(c5908650.thcost)
	e1:SetCondition(c5908650.thcon)
	e1:SetTarget(c5908650.thtg)
	e1:SetOperation(c5908650.thop)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(5908650,ACTIVITY_CHAIN,c5908650.chainfilter)
end
function c5908650.chainfilter(re,tp,cid)
	local attr=Duel.GetChainInfo(cid,CHAININFO_TRIGGERING_ATTRIBUTE)
	return not (re:IsActiveType(TYPE_MONSTER) and attr&(ATTRIBUTE_ALL&~ATTRIBUTE_LIGHT)~=0)
end
function c5908650.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(5908650,tp,ACTIVITY_CHAIN)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,0)
	e1:SetValue(c5908650.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c5908650.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsAttribute(ATTRIBUTE_LIGHT)
end
function c5908650.aclimit(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER) and re:GetHandler():IsNonAttribute(ATTRIBUTE_LIGHT)
end
function c5908650.filter(c)
	return c:IsRace(RACE_FAIRY) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsAbleToHand()
end
function c5908650.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c5908650.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c5908650.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c5908650.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c5908650.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
