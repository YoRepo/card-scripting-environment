--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 红莲新星  (ID: 21142671)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Fairy
-- Level 1
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次。
-- ①：场上有8星以上的龙族同调怪兽存在的场合，这张卡可以从手卡特殊召唤。
-- ②：调整2只以上为素材的同调召唤让这张卡作为同调素材送去墓地的场合才能发动。从卡组把1只恶魔族·炎属性怪兽守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--レッド・ノヴァ
function c21142671.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,21142671+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c21142671.spcon)
	c:RegisterEffect(e1)
	--special summon (from deck)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21142671,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCondition(c21142671.spdcon)
	e2:SetTarget(c21142671.spdtg)
	e2:SetOperation(c21142671.spdop)
	c:RegisterEffect(e2)
end
function c21142671.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and c:IsLevelAbove(8) and c:IsRace(RACE_DRAGON)
end
function c21142671.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c21142671.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c21142671.spdcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO and c:GetReasonCard():IsHasEffect(21142671)
end
function c21142671.filter(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_FIRE) and c:IsRace(RACE_FIEND)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c21142671.spdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c21142671.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c21142671.spdop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c21142671.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
