--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 神圣降诞  (ID: 85590798)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 345
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：自己主要阶段才能发动。手卡1只天使族·光属性怪兽给对方观看，从卡组把1只龙族·光属性·7星怪兽加入手卡。那之后，给人观看的怪兽回到卡组最下面。
-- ②：对方把魔法·陷阱·怪兽的效果发动的场合才能发动。从手卡把1只龙族·光属性·7星怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--聖なる降誕
function c85590798.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(85590798,0))
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND+CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,85590798)
	e2:SetTarget(c85590798.thtg)
	e2:SetOperation(c85590798.thop)
	c:RegisterEffect(e2)
	--Special Summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(85590798,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1,85590798)
	e3:SetCondition(c85590798.spcon)
	e3:SetTarget(c85590798.sptg)
	e3:SetOperation(c85590798.spop)
	c:RegisterEffect(e3)
end
function c85590798.cfilter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_FAIRY) and c:IsAbleToDeck() and not c:IsPublic()
end
function c85590798.thfilter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsLevel(7) and c:IsRace(RACE_DRAGON) and c:IsAbleToHand()
end
function c85590798.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c85590798.cfilter,tp,LOCATION_HAND,0,1,nil)
		and Duel.IsExistingMatchingCard(c85590798.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c85590798.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g1=Duel.SelectMatchingCard(tp,c85590798.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	if g1:GetCount()==0 then return end
	Duel.ConfirmCards(1-tp,g1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g2=Duel.SelectMatchingCard(tp,c85590798.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g2:GetCount()>0 and Duel.SendtoHand(g2,nil,REASON_EFFECT)~=0 then
		Duel.ConfirmCards(1-tp,g2)
		Duel.ShuffleDeck(tp)
		Duel.BreakEffect()
		Duel.SendtoDeck(g1,nil,SEQ_DECKBOTTOM,REASON_EFFECT)
	end
end
function c85590798.spcon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp
end
function c85590798.spfilter(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_DRAGON)
		and c:IsLevel(7) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c85590798.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c85590798.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c85590798.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c85590798.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
