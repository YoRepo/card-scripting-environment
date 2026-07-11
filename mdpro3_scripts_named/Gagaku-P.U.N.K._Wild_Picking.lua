--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Gagaku-P.U.N.K. Wild Picking  (ID: 81192859)
-- Type: Spell / Continuous
-- Setcode: 0x171
-- Scope: OCG / TCG
--
-- Effect Text:
-- At the start of the Damage Step, if your "P.U.N.K." monster battles an opponent's monster: You can
-- destroy that opponent's monster.
-- You can only use this effect of "Gagaku-P.U.N.K. Wild Picking" once per turn.
-- If this card in its owner's Spell & Trap Zone is destroyed by an opponent's card effect: You can
-- activate this effect; "P.U.N.K." monsters you currently control cannot be destroyed by battle this
-- turn.
--[[ __CARD_HEADER_END__ ]]

--Ga－P.U.N.K.ワイルド・ピッキング
function c81192859.initial_effect(c)
	--ACT
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(81192859,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,81192859)
	e2:SetCondition(c81192859.descon)
	e2:SetTarget(c81192859.destg)
	e2:SetOperation(c81192859.desop)
	c:RegisterEffect(e2)
	--Cannot Break
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(81192859,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCondition(c81192859.limcon)
	e3:SetOperation(c81192859.limop)
	c:RegisterEffect(e3)
end
function c81192859.descon(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetBattleMonster(tp)
	if not (ac and ac:IsFaceup() and ac:IsSetCard(0x171)) then return false end
	local bc=ac:GetBattleTarget()
	e:SetLabelObject(bc)
	return bc and bc:IsControler(1-tp) and bc:IsRelateToBattle()
end
function c81192859.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetLabelObject()
	if chk==0 then return bc end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
end
function c81192859.desop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetLabelObject()
	if bc and bc:IsControler(1-tp) and bc:IsRelateToBattle() then
		Duel.Destroy(bc,REASON_EFFECT)
	end
end
function c81192859.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x171)
end
function c81192859.limcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return rp==1-tp and c:IsReason(REASON_EFFECT) and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_SZONE)
		and Duel.GetMatchingGroupCount(c81192859.cfilter,tp,LOCATION_MZONE,0,nil)>0
end
function c81192859.limop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c81192859.cfilter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(81192859,2))
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
