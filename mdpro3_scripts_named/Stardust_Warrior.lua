--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 星尘战士  (ID: 74892653)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Warrior
-- Level 10
-- ATK 3000 | DEF 2500
-- Setcode: 6684835
--
-- Effect Text:
-- 同调怪兽调整＋调整以外的同调怪兽1只以上
-- ①：对方把怪兽特殊召唤之际，把这张卡解放才能发动。那个无效，那些怪兽破坏。
-- ②：这张卡的①的效果适用的回合的结束阶段才能发动。为那个效果发动而解放的这张卡从墓地特殊召唤。
-- ③：战斗或者对方的效果让表侧表示的这张卡从场上离开的场合才能发动。从额外卡组把1只8星以下的「战士」同调怪兽当作同调召唤作特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--スターダスト・ウォリアー
function c74892653.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSynchroType,TYPE_SYNCHRO),aux.NonTuner(Card.IsSynchroType,TYPE_SYNCHRO),1)
	c:EnableReviveLimit()
	--disable spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(74892653,0))
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_SPSUMMON)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c74892653.condition)
	e1:SetCost(c74892653.cost)
	e1:SetTarget(c74892653.target)
	e1:SetOperation(c74892653.operation)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(74892653,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1)
	e2:SetTarget(c74892653.sptg)
	e2:SetOperation(c74892653.spop)
	c:RegisterEffect(e2)
	--synchro summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(74892653,2))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_DELAY)
	e3:SetCondition(c74892653.sccon)
	e3:SetTarget(c74892653.sctg)
	e3:SetOperation(c74892653.scop)
	c:RegisterEffect(e3)
end
c74892653.material_type=TYPE_SYNCHRO
function c74892653.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=ep and Duel.GetCurrentChain()==0
end
function c74892653.excostfilter(c,tp)
	return c:IsAbleToRemoveAsCost() and c:IsHasEffect(84012625,tp)
end
function c74892653.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c74892653.excostfilter,tp,LOCATION_GRAVE,0,nil,tp)
	if e:GetHandler():IsReleasable() then g:AddCard(e:GetHandler()) end
	if chk==0 then return #g>0 end
	local tc
	if #g>1 then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(84012625,0))
		tc=g:Select(tp,1,1,nil):GetFirst()
	else
		tc=g:GetFirst()
	end
	local te=tc:IsHasEffect(84012625,tp)
	if te then
		Duel.Remove(tc,POS_FACEUP,REASON_COST+REASON_REPLACE)
	else
		Duel.Release(tc,REASON_COST)
	end
end
function c74892653.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c74892653.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
	e:GetHandler():RegisterFlagEffect(74892653,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
end
function c74892653.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(74892653)~=0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c74892653.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
function c74892653.sccon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return (c:IsReason(REASON_BATTLE) or (c:GetReasonPlayer()==1-tp and c:IsReason(REASON_EFFECT)))
		and c:IsPreviousPosition(POS_FACEUP)
end
function c74892653.filter(c,e,tp)
	return c:IsSetCard(0x66) and c:IsLevelBelow(8) and c:IsType(TYPE_SYNCHRO)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function c74892653.sctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return aux.MustMaterialCheck(nil,tp,EFFECT_MUST_BE_SMATERIAL)
		and Duel.IsExistingMatchingCard(c74892653.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c74892653.scop(e,tp,eg,ep,ev,re,r,rp)
	if not aux.MustMaterialCheck(nil,tp,EFFECT_MUST_BE_SMATERIAL) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c74892653.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		tc:SetMaterial(nil)
		if Duel.SpecialSummon(tc,SUMMON_TYPE_SYNCHRO,tp,tp,false,false,POS_FACEUP)>0 then
			tc:CompleteProcedure()
		end
	end
end
