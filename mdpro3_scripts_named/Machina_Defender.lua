--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 机甲卫兵  (ID: 96384007)
-- Type: Monster / Effect / Toon
-- Attribute: EARTH
-- Race: Machine
-- Level 4
-- ATK 1200 | DEF 1800
-- Setcode: 54
--
-- Effect Text:
-- ①：这张卡反转的场合发动。从卡组把1只「督战官 科文顿」加入手卡。
--[[ __CARD_HEADER_END__ ]]

--マシンナーズ・ディフェンダー
function c96384007.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(96384007,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c96384007.target)
	e1:SetOperation(c96384007.operation)
	c:RegisterEffect(e1)
end
function c96384007.filter(c)
	return c:IsCode(22666164) and c:IsAbleToHand()
end
function c96384007.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c96384007.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local tc=Duel.GetFirstMatchingCard(c96384007.filter,tp,LOCATION_DECK,0,nil)
	if tc then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
