--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 相剑军师-龙渊  (ID: 93490856)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Wyrm
-- Level 6
-- ATK 1200 | DEF 2300
-- Setcode: 363
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：把手卡其他的1张「相剑」卡或者1只幻龙族怪兽丢弃才能发动。这张卡从手卡特殊召唤。那之后，可以在自己场上把1只「相剑衍生物」（幻龙族·调整·水·4星·攻/守0）特殊召唤。只要这个效果特殊召唤的衍生物
-- 存在，自己不是同调怪兽不能从额外卡组特殊召唤。
-- ②：这张卡作为同调素材送去墓地的场合才能发动。给与对方1200伤害。
--[[ __CARD_HEADER_END__ ]]

--相剣軍師－龍淵
function c93490856.initial_effect(c)
	--special summon (self)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(93490856,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,93490856)
	e1:SetCost(c93490856.spcost)
	e1:SetTarget(c93490856.sptg)
	e1:SetOperation(c93490856.spop)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(93490856,1))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCountLimit(1,93490857)
	e2:SetCondition(c93490856.damcon)
	e2:SetTarget(c93490856.damtg)
	e2:SetOperation(c93490856.damop)
	c:RegisterEffect(e2)
end
function c93490856.costfilter(c)
	return (c:IsSetCard(0x16b) or (c:IsRace(RACE_WYRM) and c:IsType(TYPE_MONSTER))) and c:IsDiscardable()
end
function c93490856.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c93490856.costfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c93490856.costfilter,1,1,REASON_COST+REASON_DISCARD,e:GetHandler())
end
function c93490856.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c93490856.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		if ft>0 and Duel.IsPlayerCanSpecialSummonMonster(tp,20001444,0x16b,TYPES_TOKEN_MONSTER+TYPE_TUNER,0,0,4,RACE_WYRM,ATTRIBUTE_WATER)
			and Duel.SelectYesNo(tp,aux.Stringid(93490856,2)) then
				Duel.BreakEffect()
				local token=Duel.CreateToken(tp,93490857)
				Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_FIELD)
				e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
				e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
				e1:SetRange(LOCATION_MZONE)
				e1:SetAbsoluteRange(tp,1,0)
				e1:SetTarget(c93490856.splimit)
				e1:SetReset(RESET_EVENT+RESETS_STANDARD)
				token:RegisterEffect(e1,true)
				Duel.SpecialSummonComplete()
		end
	end
end
function c93490856.splimit(e,c)
	return not c:IsType(TYPE_SYNCHRO) and c:IsLocation(LOCATION_EXTRA)
end
function c93490856.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO
end
function c93490856.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1200)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1200)
end
function c93490856.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
