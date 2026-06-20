--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 真红眼不尸龙  (ID: 28240337)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Zombie
-- Level 7
-- ATK 2400 | DEF 2000
-- Setcode: 59
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡的攻击力·守备力上升双方的场上·墓地的不死族怪兽数量×100。
-- ②：这张卡以外的不死族怪兽被战斗破坏时才能发动。选自己或者对方的墓地1只不死族怪兽在自己场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--真紅眼の不屍竜
function c28240337.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--Atk up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c28240337.atkval)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,28240337)
	e3:SetCondition(c28240337.spcon)
	e3:SetTarget(c28240337.sptg)
	e3:SetOperation(c28240337.spop)
	c:RegisterEffect(e3)
end
function c28240337.atkval(e,c)
	return Duel.GetMatchingGroupCount(Card.IsRace,c:GetControler(),LOCATION_GRAVE+LOCATION_MZONE,LOCATION_GRAVE+LOCATION_MZONE,nil,RACE_ZOMBIE)*100
end
function c28240337.cfilter(c)
	return c:GetPreviousRaceOnField()&RACE_ZOMBIE~=0
end
function c28240337.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c28240337.cfilter,1,nil)
end
function c28240337.spfilter(c,e,tp)
	return c:IsRace(RACE_ZOMBIE) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c28240337.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c28240337.spfilter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c28240337.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c28240337.spfilter),tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
