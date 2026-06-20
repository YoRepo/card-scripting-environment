--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 星因士 天津四  (ID: 75878039)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 4
-- ATK 1500 | DEF 1000
-- Setcode: 156
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡召唤·反转召唤·特殊召唤的场合才能发动。从卡组把「星因士 天津四」以外的1只「星骑士」怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--星因士 デネブ
function c75878039.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75878039,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,75878039)
	e1:SetTarget(c75878039.target)
	e1:SetOperation(c75878039.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	c75878039.star_knight_summon_effect=e1
end
function c75878039.filter(c)
	return c:IsSetCard(0x9c) and c:IsType(TYPE_MONSTER) and not c:IsCode(75878039) and c:IsAbleToHand()
end
function c75878039.target(e,tp,eg,ep,ev,re,r,rp,chk,_,exc)
	if chk==0 then return Duel.IsExistingMatchingCard(c75878039.filter,tp,LOCATION_DECK,0,1,exc) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c75878039.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c75878039.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
