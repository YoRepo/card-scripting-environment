--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Dododo Warrior  (ID: 83274244)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 6
-- ATK 2300 | DEF 900
-- Setcode: 0x82, 0x66
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Normal Summon this card without Tributing, but its original ATK becomes 1800.
-- If this card attacks, negate all card effects that activate in the opponent's GY, until the end of
-- the Damage Step.
--[[ __CARD_HEADER_END__ ]]

--ドドドウォリアー
function c83274244.initial_effect(c)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(83274244,0))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c83274244.ntcon)
	e1:SetOperation(c83274244.ntop)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c83274244.negcon)
	e2:SetOperation(c83274244.negop)
	c:RegisterEffect(e2)
end
function c83274244.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c83274244.ntop(e,tp,eg,ep,ev,re,r,rp,c)
	--change base attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(1800)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
end
function c83274244.negcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()==e:GetHandler()
end
function c83274244.negop(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if ep~=tp and loc==LOCATION_GRAVE then
		Duel.NegateEffect(ev)
	end
end
