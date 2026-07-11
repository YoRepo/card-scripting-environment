--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Soul Pendulum  (ID: 34884015)
-- Type: Spell / Continuous
-- Setcode: 0xf2
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can target 2 cards in your Pendulum Zones; change each target's Pendulum Scale by 1 (min. 1).
-- You can only use this effect of "Soul Pendulum" once per turn.
-- Each time your Pendulum Monster(s) is Pendulum Summoned, place 1 counter on this card.
-- Pendulum Monsters on the field gain 300 ATK for each counter on this card.
-- You can remove 3 counters from this card; during your Main Phase this turn, you can conduct 1
-- Pendulum Summon of a monster(s) in addition to your Pendulum Summon.
-- (You can only gain this effect once per turn.)
--[[ __CARD_HEADER_END__ ]]

--魂のペンデュラム
function c34884015.initial_effect(c)
	c:EnableCounterPermit(0x4e)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--scale
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(34884015,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,34884015)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c34884015.target)
	e2:SetOperation(c34884015.operation)
	c:RegisterEffect(e2)
	--counter
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetRange(LOCATION_SZONE)
	e3:SetOperation(c34884015.counterop)
	c:RegisterEffect(e3)
	--atk up
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e4:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_PENDULUM))
	e4:SetValue(c34884015.atkval)
	c:RegisterEffect(e4)
	--extra pendulum
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(34884015,3))
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCost(c34884015.expcost)
	e5:SetTarget(c34884015.exptg)
	e5:SetOperation(c34884015.expop)
	c:RegisterEffect(e5)
end
function c34884015.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_PZONE,0,2,nil) end
	local g=Duel.GetFieldGroup(tp,LOCATION_PZONE,0)
	Duel.SetTargetCard(g)
end
function c34884015.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg=g:Filter(Card.IsRelateToEffect,nil,e)
	local tc=tg:GetFirst()
	while tc do
		Duel.HintSelection(Group.FromCards(tc))
		local sel=0
		if tc:GetLeftScale()<=1 then
			sel=Duel.SelectOption(tp,aux.Stringid(34884015,1))
		else
			sel=Duel.SelectOption(tp,aux.Stringid(34884015,1),aux.Stringid(34884015,2))
		end
		local ct=1
		if sel==1 then
			ct=-1
		end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LSCALE)
		e1:SetValue(ct)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_RSCALE)
		tc:RegisterEffect(e2)
		tc=tg:GetNext()
	end
end
function c34884015.cfilter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM) and c:IsControler(tp) and c:IsSummonType(SUMMON_TYPE_PENDULUM)
end
function c34884015.counterop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c34884015.cfilter,1,nil,tp) then
		e:GetHandler():AddCounter(0x4e,1)
	end
end
function c34884015.atkval(e,c)
	return e:GetHandler():GetCounter(0x4e)*300
end
function c34884015.expcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x4e,3,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x4e,3,REASON_COST)
end
function c34884015.exptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,34884015)==0 end
end
function c34884015.expop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(34884015,4))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_EXTRA_PENDULUM_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetCountLimit(1,29432356)
	e1:SetValue(aux.TRUE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,34884015,RESET_PHASE+PHASE_END,0,1)
end
