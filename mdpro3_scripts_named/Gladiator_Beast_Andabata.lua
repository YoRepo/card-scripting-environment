--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 剑斗兽 盲斗  (ID: 3779662)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Beast-Warrior
-- Level 8
-- ATK 1000 | DEF 2800
-- Setcode: 4121
--
-- Effect Text:
-- 「剑斗兽 奥古斯都」＋「剑斗兽」怪兽×2
-- 让自己场上的上记卡回到卡组的场合才能从额外卡组特殊召唤（不需要「融合」）。
-- ①：这张卡用上记的方法特殊召唤成功的场合才能发动。从额外卡组把1只7星以下的「剑斗兽」融合怪兽无视召唤条件特殊召唤。
-- ②：这张卡进行战斗的战斗阶段结束时让这张卡回到持有者的额外卡组才能发动。从卡组把2只「剑斗兽」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--剣闘獣アンダバタエ
function c3779662.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,7573135,aux.FilterBoolFunction(Card.IsFusionSetCard,0x1019),2,true,true)
	aux.AddContactFusionProcedure(c,c3779662.cfilter,LOCATION_ONFIELD,0,aux.ContactFusionSendToDeck(c)):SetValue(SUMMON_VALUE_SELF)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c3779662.splimit)
	c:RegisterEffect(e1)
	--extra summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(3779662,4))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCondition(c3779662.espcon)
	e3:SetTarget(c3779662.esptg)
	e3:SetOperation(c3779662.espop)
	c:RegisterEffect(e3)
	--special summon
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(3779662,5))
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e6:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCondition(c3779662.spcon)
	e6:SetCost(c3779662.spcost)
	e6:SetTarget(c3779662.sptg)
	e6:SetOperation(c3779662.spop)
	c:RegisterEffect(e6)
end
function c3779662.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
function c3779662.cfilter(c)
	return (c:IsFusionCode(7573135) or c:IsFusionSetCard(0x1019) and c:IsType(TYPE_MONSTER))
		and c:IsAbleToDeckOrExtraAsCost()
end
function c3779662.espcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+SUMMON_VALUE_SELF
end
function c3779662.espfilter(c,e,tp)
	return c:IsSetCard(0x1019) and c:IsType(TYPE_FUSION) and c:IsLevelBelow(7)
		and c:IsCanBeSpecialSummoned(e,0,tp,true,false) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function c3779662.esptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c3779662.espfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c3779662.espop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c3779662.espfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end
function c3779662.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattledGroupCount()>0
end
function c3779662.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToExtraAsCost() end
	Duel.SendtoDeck(c,nil,SEQ_DECKTOP,REASON_COST)
end
function c3779662.spfilter(c,e,tp)
	return c:IsSetCard(0x1019) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c3779662.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		if e:GetHandler():GetSequence()<5 then ft=ft+1 end
		return ft>1 and not Duel.IsPlayerAffectedByEffect(tp,59822133)
			and Duel.IsExistingMatchingCard(c3779662.spfilter,tp,LOCATION_DECK,0,2,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK)
end
function c3779662.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	local g=Duel.GetMatchingGroup(c3779662.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if g:GetCount()>=2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,2,2,nil)
		local tc=sg:GetFirst()
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		tc:RegisterFlagEffect(tc:GetOriginalCode(),RESET_EVENT+RESETS_STANDARD+RESET_DISABLE,0,0)
		tc=sg:GetNext()
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		tc:RegisterFlagEffect(tc:GetOriginalCode(),RESET_EVENT+RESETS_STANDARD+RESET_DISABLE,0,0)
		Duel.SpecialSummonComplete()
	end
end
