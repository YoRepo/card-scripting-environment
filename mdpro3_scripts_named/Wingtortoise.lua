--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 翼龟  (ID: 10132124)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Aqua
-- Level 3
-- ATK 1500 | DEF 1400
--
-- Effect Text:
-- 自己场上表侧表示存在的鱼族·海龙族·水族怪兽从游戏中除外时，这张卡可以从手卡或者自己墓地特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ウイングトータス
function c10132124.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10132124,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCode(EVENT_REMOVE)
	e1:SetCondition(c10132124.spcon)
	e1:SetTarget(c10132124.sptg)
	e1:SetOperation(c10132124.spop)
	c:RegisterEffect(e1)
end
function c10132124.spfilter(c,tp)
	return c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousLocation(LOCATION_MZONE)
		and c:IsPreviousControler(tp) and c:IsRace(RACE_FISH+RACE_SEASERPENT+RACE_AQUA)
end
function c10132124.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c10132124.spfilter,1,nil,tp)
end
function c10132124.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c10132124.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
