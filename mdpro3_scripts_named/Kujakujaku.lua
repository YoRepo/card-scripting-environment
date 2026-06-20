--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 九蛇孔雀  (ID: 24384095)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level 3
-- ATK 1200 | DEF 900
--
-- Effect Text:
-- 场上的这张卡被解放送去墓地的场合，可以从自己的卡组·墓地选「九蛇孔雀」以外的1只4星以下的风属性怪兽加入手卡。「九蛇孔雀」的效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--九蛇孔雀
function c24384095.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(24384095,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,24384095)
	e1:SetCondition(c24384095.thcon)
	e1:SetTarget(c24384095.thtg)
	e1:SetOperation(c24384095.thop)
	c:RegisterEffect(e1)
end
function c24384095.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD) and e:GetHandler():IsReason(REASON_RELEASE)
end
function c24384095.filter(c)
	return c:IsLevelBelow(4) and c:IsAttribute(ATTRIBUTE_WIND) and not c:IsCode(24384095) and c:IsAbleToHand()
end
function c24384095.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c24384095.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c24384095.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c24384095.filter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
