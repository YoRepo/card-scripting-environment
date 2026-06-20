--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 加速同调士  (ID: 37675907)
-- Type: Monster / Effect / Tuner / Synchro
-- Attribute: DARK
-- Race: Machine
-- Level 5
-- ATK 500 | DEF 2100
-- Setcode: 4119
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 自己对「加速同调士」1回合只能有1次同调召唤。
-- ①：1回合1次，可以从卡组把1只「同调士」怪兽送去墓地，从以下效果选择1个发动。
-- ●这张卡的等级上升那只怪兽的等级数值。
-- ●这张卡的等级下降那只怪兽的等级数值。
-- ②：对方主要阶段才能发动（同一连锁上最多1次）。用包含这张卡的自己场上的怪兽为素材进行同调召唤。
--[[ __CARD_HEADER_END__ ]]

--アクセル・シンクロン
function c37675907.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c37675907.regcon)
	e1:SetOperation(c37675907.regop)
	c:RegisterEffect(e1)
	--lv
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(37675907,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c37675907.tgcost)
	e2:SetTarget(c37675907.tgtg)
	e2:SetOperation(c37675907.tgop)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(37675907,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c37675907.spcon)
	e3:SetTarget(c37675907.sptg)
	e3:SetOperation(c37675907.spop)
	c:RegisterEffect(e3)
end
function c37675907.regcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c37675907.regop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTarget(c37675907.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c37675907.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsCode(37675907) and bit.band(sumtype,SUMMON_TYPE_SYNCHRO)==SUMMON_TYPE_SYNCHRO
end
function c37675907.filter(c)
	return c:GetLevel()>0 and c:IsSetCard(0x1017) and c:IsAbleToGraveAsCost()
end
function c37675907.tgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c37675907.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c37675907.filter,tp,LOCATION_DECK,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
	e:SetLabelObject(g:GetFirst())
end
function c37675907.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local lv=e:GetHandler():GetLevel()
	if chk==0 then return lv>0 end
	local opt
	if e:GetLabelObject():GetLevel()<lv then
		opt=Duel.SelectOption(tp,aux.Stringid(37675907,2),aux.Stringid(37675907,3))
	else
		opt=Duel.SelectOption(tp,aux.Stringid(37675907,2))
	end
	e:SetLabel(opt)
end
function c37675907.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local lv=e:GetLabelObject():GetLevel()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		if e:GetLabel()==0 then
			e1:SetValue(lv)
		else
			e1:SetValue(-lv)
		end
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
function c37675907.spcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()~=tp and (ph==PHASE_MAIN1 or ph==PHASE_MAIN2)
end
function c37675907.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsStatus(STATUS_CHAINING)
		and Duel.IsExistingMatchingCard(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,1,nil,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c37675907.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsControler(1-tp) or not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local g=Duel.GetMatchingGroup(Card.IsSynchroSummonable,tp,LOCATION_EXTRA,0,nil,c)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SynchroSummon(tp,sg:GetFirst(),c)
	end
end
