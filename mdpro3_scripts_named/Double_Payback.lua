--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Double Payback  (ID: 5914184)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Activate only when you take 1000 or more damage from your opponent's card effect: Place 1 Payback
-- Counter on this card for every 1000 damage you took.
-- During the End Phase of your opponent's next turn: Destroy this card, and if you do, inflict 2000
-- damage to your opponent for each Payback Counter on this card.
--[[ __CARD_HEADER_END__ ]]

--倍返し
function c5914184.initial_effect(c)
	c:EnableCounterPermit(0x1a)
	--counter
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetCondition(c5914184.actcon)
	e1:SetTarget(c5914184.acttg)
	e1:SetOperation(c5914184.actop)
	c:RegisterEffect(e1)
end
function c5914184.actcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and 1-tp==rp and ev>=1000 and bit.band(r,REASON_EFFECT)~=0
end
function c5914184.acttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanAddCounter(tp,0x1a,math.floor(ev/1000),e:GetHandler()) end
end
function c5914184.actop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local ct=math.floor(ev/1000)
		c:AddCounter(0x1a,ct)
		--damage
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(5914184,0))
		e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetRange(LOCATION_SZONE)
		e1:SetCountLimit(1)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCondition(c5914184.damcon)
		e1:SetTarget(c5914184.damtg)
		e1:SetOperation(c5914184.damop)
		if Duel.GetTurnPlayer()==tp then
			e1:SetLabel(0)
			e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		else
			e1:SetLabel(Duel.GetTurnCount())
			e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
		end
		c:RegisterEffect(e1)
	end
end
function c5914184.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetTurnCount()~=e:GetLabel()
end
function c5914184.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	local dam=e:GetHandler():GetCounter(0x1a)*2000;
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c5914184.damop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Destroy(e:GetHandler(),REASON_EFFECT)~=0 then
		local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
		Duel.Damage(p,d,REASON_EFFECT)
	end
end
