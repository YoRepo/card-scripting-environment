--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 神手粉碎拳  (ID: 79868386)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。这张卡的发动和效果不会被无效化。
-- ①：自己场上有原本卡名是「欧贝利斯克之巨神兵」的怪兽存在的场合才能发动。选对方场上1只效果怪兽，把效果无效并破坏。这个回合，这个效果破坏的怪兽以及原本卡名和那只怪兽相同的怪兽的效果无效化。这张卡在自己
-- 主要阶段发动的场合，可以再让以下效果适用。
-- ●对方场上的魔法·陷阱卡全部破坏。
--[[ __CARD_HEADER_END__ ]]

--ゴッド・ハンド・クラッシャー
function c79868386.initial_effect(c)
	aux.AddCodeList(c,10000000)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CAN_FORBIDDEN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetCountLimit(1,79868386+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c79868386.condition)
	e1:SetTarget(c79868386.target)
	e1:SetOperation(c79868386.activate)
	c:RegisterEffect(e1)
end
function c79868386.actfilter(c)
	return c:IsFaceup() and c:IsOriginalCodeRule(10000000)
end
function c79868386.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c79868386.actfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c79868386.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.NegateEffectMonsterFilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,0,0)
end
function c79868386.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISABLE)
	local g=Duel.SelectMatchingCard(tp,aux.NegateEffectMonsterFilter,tp,0,LOCATION_MZONE,1,1,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		Duel.AdjustInstantly()
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		if Duel.Destroy(tc,REASON_EFFECT)~=0 then
			local e3=Effect.CreateEffect(e:GetHandler())
			e3:SetType(EFFECT_TYPE_FIELD)
			e3:SetCode(EFFECT_DISABLE)
			e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
			e3:SetTarget(c79868386.distg)
			e3:SetLabelObject(tc)
			e3:SetReset(RESET_PHASE+PHASE_END)
			Duel.RegisterEffect(e3,tp)
			local e4=Effect.CreateEffect(e:GetHandler())
			e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e4:SetCode(EVENT_CHAIN_SOLVING)
			e4:SetCondition(c79868386.discon)
			e4:SetOperation(c79868386.disop)
			e4:SetLabelObject(tc)
			e4:SetReset(RESET_PHASE+PHASE_END)
			Duel.RegisterEffect(e4,tp)
			local sg=Duel.GetMatchingGroup(c79868386.desfilter,tp,0,LOCATION_ONFIELD,nil)
			if #sg>0 and Duel.GetTurnPlayer()==tp
				and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
				and Duel.SelectYesNo(tp,aux.Stringid(79868386,0)) then
				Duel.BreakEffect()
				Duel.Destroy(sg,REASON_EFFECT)
			end
		end
	end
end
function c79868386.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c79868386.distg(e,c)
	local tc=e:GetLabelObject()
	return c:IsOriginalCodeRule(tc:GetOriginalCodeRule())
end
function c79868386.discon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return re:IsActiveType(TYPE_MONSTER) and re:GetHandler():IsOriginalCodeRule(tc:GetOriginalCodeRule())
end
function c79868386.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
