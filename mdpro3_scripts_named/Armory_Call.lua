--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 武器呼唤  (ID: 38960450)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从卡组把1张装备魔法卡加入手卡。那之后，可以给可以把那张卡装备的自己场上1只怪兽装备。
--[[ __CARD_HEADER_END__ ]]

--アームズ・コール
function c38960450.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,38960450+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c38960450.target)
	e1:SetOperation(c38960450.activate)
	c:RegisterEffect(e1)
end
function c38960450.filter(c)
	return c:IsType(TYPE_EQUIP) and c:IsAbleToHand()
end
function c38960450.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c38960450.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c38960450.eqfilter(c,tc)
	return c:IsFaceup() and tc:CheckEquipTarget(c)
end
function c38960450.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g1=Duel.SelectMatchingCard(tp,c38960450.filter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g1:GetFirst()
	if tc and Duel.SendtoHand(tc,nil,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_HAND) then
		Duel.ConfirmCards(1-tp,g1)
		local g2=Duel.GetMatchingGroup(c38960450.eqfilter,tp,LOCATION_MZONE,0,nil,tc)
		if tc:CheckUniqueOnField(tp) and not tc:IsForbidden() and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
			and g2:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(38960450,0)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
			local sg=g2:Select(tp,1,1,nil)
			Duel.Equip(tp,tc,sg:GetFirst())
		end
	end
end
