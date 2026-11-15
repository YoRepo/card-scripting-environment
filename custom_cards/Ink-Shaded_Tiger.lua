--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-11-15T00:00:00
-- Card: Ink-Shaded Tiger  (ID: 99811040)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Illusion
-- Level 7
-- ATK 2400 | DEF 2200
-- Setcode: 0x1961 (Ink-Shaded)
--
-- Materials: 1 "Ink Shader" monster + 1 EARTH monster
--
-- Effect Text:
-- Must either be Fusion Summoned, or Special Summoned (from your Extra Deck) by sending 1 Spell/Trap
-- from the field to the GY while you control a Level 7 or higher "Ink Shader" monster. You can only
-- Special Summon "Ink-Shaded Tiger(s)" once per turn. You can only use 1 "Ink-Shaded Tiger" effect per
-- turn and only once that turn.
-- ① (Quick Effect): You can return 1 "Ink Shader" monster you control to the hand or Extra Deck; this
-- card gains the ATK it had on the field.
-- ② If this card is in your GY (Quick Effect): You can return this card to the Extra Deck, then target
-- 1 of your banished "Ink-Shade" Spell/Traps; Set it.
--[[ __CARD_HEADER_END__ ]]

--Ink-Shaded Tiger
local s,id,o=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	--you can only Special Summon "Ink-Shaded Tiger(s)" once per turn (any method: no "this way")
	c:SetSPSummonOnce(id)
	--fusion material: 1 "Ink Shader" monster + 1 EARTH monster
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x960),aux.FilterBoolFunction(Card.IsFusionAttribute,ATTRIBUTE_EARTH),true)
	--must be Fusion Summoned, or Special Summoned by the procedure below, which the engine does not check
	--against this (cf. Artmage Non-Finito, Divine Serpent Apophis)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(aux.fuslimit)
	c:RegisterEffect(e0)
	--SS proc (from Extra Deck): send 1 Spell/Trap from the field to the GY while you control a Level 7+ "Ink Shader" monster
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(s.spcon)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--you can only use 1 "Ink-Shaded Tiger" effect per turn, and only once that turn: (1) and (2) share
	--one count (cf. Odd-Eyes Solblaze Dragon)
	--(1) (Quick Effect): return 1 "Ink Shader" monster you control to the hand/Extra Deck; this card gains the
	--ATK that monster had on the field. No timing in the text and all it does is raise ATK, so it can also be
	--used in the Damage Step, up to damage calculation (cf. Flying Red Carp, Cyber Dragon Nova)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_MZONE)
	e2:SetHintTiming(TIMING_DAMAGE_STEP,TIMING_DAMAGE_STEP+TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e2:SetCountLimit(1,id)
	e2:SetCondition(aux.dscon)
	e2:SetCost(s.atkcost)
	e2:SetOperation(s.atkop)
	c:RegisterEffect(e2)
	--(2) (Quick Effect) from GY: return this card to the Extra Deck, then target 1 of your banished "Ink-Shade" Spells/Traps; Set it
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_SSET)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e3:SetCountLimit(1,id)
	e3:SetCost(s.setcost)
	e3:SetTarget(s.settg)
	e3:SetOperation(s.setop)
	c:RegisterEffect(e3)
end
--SS proc (send 1 Spell/Trap from the field to the GY while you control a Level 7+ "Ink Shader" monster)
function s.lvfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x960) and c:IsLevelAbove(7)
end
--"from the field": either player's, face-up or Set (cf. Trap Eater, which sends an opponent's Trap).
--A Monster Card treated as a Continuous Spell counts; one that would be banished instead cannot be sent as cost
function s.spcfilter(c,tp,sc)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToGraveAsCost()
		and Duel.GetLocationCountFromEx(tp,tp,c,sc)>0
end
function s.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(s.lvfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(s.spcfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil,tp,c)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(s.spcfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil,tp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function s.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local tc=e:GetLabelObject()
	Duel.SendtoGrave(tc,REASON_SPSUMMON)
end
--(1)
--"to the hand or Extra Deck": IsAbleToHandAsCost is false for every Extra Deck monster, so a Synchro/Fusion
--"Ink Shader" monster is checked with IsAbleToExtraAsCost; SendtoHand sends it to the Extra Deck
--(cf. Harpie's Pet Chained Dragon)
function s.rthfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x960) and (c:IsAbleToHandAsCost() or c:IsAbleToExtraAsCost())
end
function s.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.rthfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectMatchingCard(tp,s.rthfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.HintSelection(g)
	--"the ATK it had on the field": read before it leaves
	e:SetLabel(g:GetFirst():GetAttack())
	Duel.SendtoHand(g,nil,REASON_COST)
end
function s.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local atk=e:GetLabel()
	if c:IsRelateToChain() and c:IsFaceup() and atk>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
--(2)
function s.setcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToExtraAsCost() end
	Duel.SendtoDeck(c,nil,SEQ_DECKSHUFFLE,REASON_COST)
end
--(cf. Sloppy Stasher Squirrel)
function s.setfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x961) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
end
function s.settg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and s.setfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.setfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	Duel.SelectTarget(tp,s.setfilter,tp,LOCATION_REMOVED,0,1,1,nil)
end
function s.setop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToChain() then
		Duel.SSet(tp,tc)
	end
end
