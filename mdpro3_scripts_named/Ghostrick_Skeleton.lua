--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Ghostrick Skeleton  (ID: 51196805)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level: 3
-- ATK 1200 | DEF 1100
-- Setcode: 0x8d
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Normal Summoned, unless you control a "Ghostrick" monster.
-- Once per turn: You can change this card to face-down Defense Position.
-- When this card is flipped face-up: Banish cards from the top of your opponent's Deck face-down, up
-- to the number of "Ghostrick" monsters you control.
-- You can only use this effect of "Ghostrick Skeleton" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ゴーストリック・スケルトン
function c51196805.initial_effect(c)
	--summon limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetCondition(c51196805.sumcon)
	c:RegisterEffect(e1)
	--turn set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(51196805,0))
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c51196805.postg)
	e2:SetOperation(c51196805.posop)
	c:RegisterEffect(e2)
	--banish
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(51196805,1))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCountLimit(1,51196805)
	e3:SetCode(EVENT_FLIP)
	e3:SetTarget(c51196805.rmtg)
	e3:SetOperation(c51196805.rmop)
	c:RegisterEffect(e3)
end
function c51196805.sfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x8d)
end
function c51196805.sumcon(e)
	return not Duel.IsExistingMatchingCard(c51196805.sfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c51196805.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanTurnSet() and c:GetFlagEffect(51196805)==0 end
	c:RegisterFlagEffect(51196805,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,c,1,0,0)
end
function c51196805.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)
	end
end
function c51196805.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_DECK)
end
function c51196805.rmop(e,tp,eg,ep,ev,re,r,rp)
	local ct1=Duel.GetMatchingGroupCount(c51196805.sfilter,tp,LOCATION_MZONE,0,nil)
	local ct2=Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)
	if ct1>ct2 then ct1=ct2 end
	if ct1==0 then return end
	local t={}
	for i=1,ct1 do t[i]=i end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(51196805,2))
	local ac=Duel.AnnounceNumber(tp,table.unpack(t))
	local g=Duel.GetDecktopGroup(1-tp,ac)
	Duel.DisableShuffleCheck()
	Duel.Remove(g,POS_FACEDOWN,REASON_EFFECT)
end
