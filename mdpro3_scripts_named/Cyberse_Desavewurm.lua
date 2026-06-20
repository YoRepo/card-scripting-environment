--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 电子界无效亚龙  (ID: 92422871)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Cyberse
-- Level 6
-- ATK 2300 | DEF 1500
-- Setcode: 147
--
-- Effect Text:
-- 电子界族的仪式·融合·同调·超量·连接怪兽＋电子界族怪兽
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己主要阶段才能发动。从手卡把1只电子界族怪兽特殊召唤。那之后，可以把这张卡的等级变成和这个效果特殊召唤的怪兽相同。
-- ②：自己场上有连接4以上的电子界族怪兽存在，对方把魔法·陷阱卡的效果发动时，把场上·墓地的这张卡除外才能发动。那个发动无效。
--[[ __CARD_HEADER_END__ ]]

--サイバース・ディセーブルム
function c92422871.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c92422871.matfilter,aux.FilterBoolFunction(Card.IsRace,RACE_CYBERSE),true)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(92422871,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,92422871)
	e1:SetTarget(c92422871.sptg)
	e1:SetOperation(c92422871.spop)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(92422871,1))
	e2:SetCategory(CATEGORY_NEGATE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE+LOCATION_GRAVE)
	e2:SetCountLimit(1,92422872)
	e2:SetCondition(c92422871.negcon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c92422871.negtg)
	e2:SetOperation(c92422871.negop)
	c:RegisterEffect(e2)
end
function c92422871.matfilter(c)
	return c:IsFusionType(TYPE_RITUAL+TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ+TYPE_LINK) and c:IsRace(RACE_CYBERSE)
end
function c92422871.spfilter(c,e,tp)
	return c:IsRace(RACE_CYBERSE) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c92422871.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c92422871.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c92422871.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c92422871.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local c=e:GetHandler()
	if #g>0 then
		local tc=g:GetFirst()
		if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0
			and c:IsFaceup() and c:IsRelateToChain()
			and c:GetLevel()>0 and c:GetLevel()~=tc:GetLevel()
			and Duel.SelectYesNo(tp,aux.Stringid(92422871,2)) then
			Duel.BreakEffect()
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_LEVEL)
			e1:SetValue(tc:GetLevel())
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
			c:RegisterEffect(e1)
		end
	end
end
function c92422871.cfilter(c)
	return c:IsRace(RACE_CYBERSE) and c:IsType(TYPE_LINK) and c:IsLinkAbove(4)
end
function c92422871.negcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not Duel.IsExistingMatchingCard(c92422871.cfilter,tp,LOCATION_MZONE,0,1,nil) then return false end
	return not c:IsStatus(STATUS_BATTLE_DESTROYED) and ep~=tp and re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and Duel.IsChainNegatable(ev)
end
function c92422871.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c92422871.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
end
