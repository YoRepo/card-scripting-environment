--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 蛇头石像怪  (ID: 64379261)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Rock
-- Level 3
-- ATK 1000 | DEF 800
--
-- Effect Text:
-- 自己对岩石族怪兽的召唤成功时，这张卡可以从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ゴルゴニック・ガーゴイル
function c64379261.initial_effect(c)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(64379261,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c64379261.spcon)
	e1:SetTarget(c64379261.sptg)
	e1:SetOperation(c64379261.spop)
	c:RegisterEffect(e1)
end
function c64379261.spcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and eg:GetFirst():IsRace(RACE_ROCK)
end
function c64379261.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c64379261.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
