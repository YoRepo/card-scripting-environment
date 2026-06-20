--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 炎狱地狱犬  (ID: 23297235)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Beast
-- Level 4
-- ATK 1900 | DEF 200
-- Setcode: 44
--
-- Effect Text:
-- ①：这张卡战斗破坏对方怪兽送去墓地时才能发动。从卡组把「炎狱地狱犬」以外的1只守备力200以下的炎属性怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--フレムベル・ヘルドッグ
function c23297235.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23297235,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(aux.bdogcon)
	e1:SetTarget(c23297235.sptg)
	e1:SetOperation(c23297235.spop)
	c:RegisterEffect(e1)
end
function c23297235.filter(c,e,tp)
	return c:IsDefenseBelow(200) and c:IsAttribute(ATTRIBUTE_FIRE) and not c:IsCode(23297235)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c23297235.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c23297235.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c23297235.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c23297235.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
