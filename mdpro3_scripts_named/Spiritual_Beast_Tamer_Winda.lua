--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 精灵兽使 薇茵妲  (ID: 65193366)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Psychic
-- Level 4
-- ATK 1600 | DEF 1800
-- Setcode: 280305845
--
-- Effect Text:
-- 自己对「精灵兽使 薇茵妲」1回合只能有1次特殊召唤。
-- ①：这张卡被对方破坏的场合才能发动。从卡组·额外卡组把1只「灵兽」怪兽无视召唤条件特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--精霊獣使い ウィンダ
function c65193366.initial_effect(c)
	c:SetSPSummonOnce(65193366)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(65193366,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetCondition(c65193366.spcon)
	e1:SetTarget(c65193366.sptg)
	e1:SetOperation(c65193366.spop)
	c:RegisterEffect(e1)
end
function c65193366.spcon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and e:GetHandler():IsPreviousControler(tp)
end
function c65193366.spfilter(c,e,tp)
	return c:IsSetCard(0xb5) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
		and (c:IsLocation(LOCATION_DECK) and Duel.GetMZoneCount(tp)>0
			or c:IsLocation(LOCATION_EXTRA) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0)
end
function c65193366.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65193366.spfilter,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_EXTRA)
end
function c65193366.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c65193366.spfilter,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end
