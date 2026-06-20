--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 天威龙-宽恕蟠龙  (ID: 87052196)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Wyrm
-- Level 7
-- ATK 1600 | DEF 2600
-- Setcode: 300
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己场上没有效果怪兽存在的场合才能发动。这张卡从手卡特殊召唤。
-- ②：自己场上有效果怪兽以外的表侧表示怪兽存在的场合，把手卡·墓地的这张卡除外才能发动。从卡组把「天威龙-宽恕蟠龙」以外的1只「天威」怪兽特殊召唤。这个效果的发动后，直到回合结束时自己不是幻龙族怪兽不能
-- 特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--天威龍－アシュナ
function c87052196.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(87052196,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,87052196)
	e1:SetCondition(c87052196.spcon)
	e1:SetTarget(c87052196.sptg)
	e1:SetOperation(c87052196.spop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(87052196,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e2:SetCountLimit(1,87052197)
	e2:SetCondition(c87052196.spcon2)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c87052196.sptg2)
	e2:SetOperation(c87052196.spop2)
	c:RegisterEffect(e2)
end
function c87052196.spcfilter(c)
	return c:IsType(TYPE_EFFECT) and c:IsFaceup()
end
function c87052196.spcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c87052196.spcfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c87052196.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c87052196.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c87052196.spfilter1(c)
	return not c:IsType(TYPE_EFFECT) and c:IsFaceup()
end
function c87052196.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c87052196.spfilter1,tp,LOCATION_MZONE,0,1,nil)
end
function c87052196.filter(c,e,tp)
	return c:IsSetCard(0x12c) and not c:IsCode(87052196) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c87052196.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c87052196.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c87052196.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c87052196.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c87052196.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c87052196.splimit(e,c)
	return not c:IsRace(RACE_WYRM)
end
