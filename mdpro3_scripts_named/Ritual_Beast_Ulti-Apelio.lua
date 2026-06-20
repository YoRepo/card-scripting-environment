--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 圣灵兽骑 火狮  (ID: 86274272)
-- Type: Monster / Effect / Fusion
-- Attribute: WIND
-- Race: Pyro
-- Level 6
-- ATK 2600 | DEF 400
-- Setcode: 16565
--
-- Effect Text:
-- 「灵兽使」怪兽＋「精灵兽」怪兽
-- 把自己场上的上记的卡除外的场合才能特殊召唤。
-- ①：这张卡攻击的场合，直到伤害步骤结束时不受其他卡的效果影响。
-- ②：自己·对方回合，让这张卡回到额外卡组，以自己的除外状态的1只「灵兽使」怪兽和1只「精灵兽」怪兽为对象才能发动。那些怪兽守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--聖霊獣騎 アペライオ
function c86274272.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x10b5),aux.FilterBoolFunction(Card.IsFusionSetCard,0x20b5),true)
	aux.AddContactFusionProcedure(c,Card.IsAbleToRemoveAsCost,LOCATION_MZONE,0,Duel.Remove,POS_FACEUP,REASON_COST)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--immune
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetCondition(c86274272.immcon)
	e3:SetValue(c86274272.efilter)
	c:RegisterEffect(e3)
	--special summon
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetHintTiming(0,TIMING_END_PHASE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCost(c86274272.spcost)
	e4:SetTarget(c86274272.sptg)
	e4:SetOperation(c86274272.spop)
	c:RegisterEffect(e4)
end
function c86274272.immcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end
function c86274272.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c86274272.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToExtraAsCost() end
	Duel.SendtoDeck(e:GetHandler(),nil,SEQ_DECKTOP,REASON_COST)
end
function c86274272.filter1(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x10b5) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
		and Duel.IsExistingTarget(c86274272.filter2,tp,LOCATION_REMOVED,0,1,c,e,tp)
end
function c86274272.filter2(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x20b5) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c86274272.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.GetMZoneCount(tp,e:GetHandler())>1
		and Duel.IsExistingTarget(c86274272.filter1,tp,LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectTarget(tp,c86274272.filter1,tp,LOCATION_REMOVED,0,1,1,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectTarget(tp,c86274272.filter2,tp,LOCATION_REMOVED,0,1,1,g1:GetFirst(),e,tp)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g1,2,0,0)
end
function c86274272.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()==0 then return end
	if g:GetCount()<=ft then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,ft,ft,nil)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		g:Sub(sg)
		Duel.SendtoGrave(g,REASON_RULE)
	end
end
