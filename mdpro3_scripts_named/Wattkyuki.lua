--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 电气穷奇  (ID: 67752972)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Thunder
-- Level 8
-- ATK 1600 | DEF 1700
-- Setcode: 14
--
-- Effect Text:
-- 「电气」调整＋调整以外的雷族怪兽1只以上
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡可以直接攻击。
-- ②：这张卡直接攻击给与对方战斗伤害时才能发动。自己墓地的「电气」调整1只和调整以外的自己场上的表侧表示的雷族怪兽1只回到卡组，从额外卡组把「电气穷奇」以外的1只「电气」同调怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--エレキュウキ
local s,id,o=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	--material
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0xe),aux.NonTuner(Card.IsRace,RACE_THUNDER),1)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCountLimit(1,id)
	e2:SetCondition(s.condition)
	e2:SetTarget(s.target)
	e2:SetOperation(s.operation)
	c:RegisterEffect(e2)
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==1-tp and Duel.GetAttackTarget()==nil
end
function s.nfilter(c,e,tp,op)
	return c:IsFaceup() and c:IsRace(RACE_THUNDER) and not c:IsType(TYPE_TUNER) and c:IsAbleToDeck()
		and Duel.IsExistingMatchingCard(s.tfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,c,op)
end
function s.tfilter(c,e,tp,c1,op)
	return c:IsSetCard(0xe) and c:IsType(TYPE_TUNER) and c:IsAbleToDeck()
		and (op or Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,Group.FromCards(c,c1)))
end
function s.spfilter(c,e,tp,g,chk)
	return c:IsType(TYPE_SYNCHRO) and c:IsSetCard(0xe) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and not c:IsCode(id) and (chk or Duel.GetLocationCountFromEx(tp,tp,g,c)>0)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.nfilter,tp,LOCATION_MZONE,0,1,nil,e,tp,false) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,2,tp,LOCATION_MZONE+LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,nil,1,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	local opchk=not Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,nil,true)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g1=Duel.SelectMatchingCard(tp,s.nfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp,opchk)
	if #g1<0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g2=Duel.SelectMatchingCard(tp,s.tfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,g1:GetFirst(),opchk)
	g1:Merge(g2)
	Duel.HintSelection(g1)
	if Duel.SendtoDeck(g1,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)<2
		or not g1:IsExists(Card.IsLocation,1,nil,LOCATION_DECK+LOCATION_EXTRA) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,nil)
	if #sg>0 then
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
