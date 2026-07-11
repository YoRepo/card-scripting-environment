--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Penguin Squire  (ID: 14761450)
-- Type: Monster / Effect / Tuner
-- Attribute: WATER
-- Race: Aqua
-- Level: 5
-- ATK 1800 | DEF 600
-- Setcode: 0x5a
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be used as Synchro Material, except for the Synchro Summon of a WATER monster.
-- If a monster is Set on your field (except during the Damage Step): You can Special Summon this card
-- from your hand, then you can reduce its Level by 1 or 2.
-- You can target 1 face-down Defense Position monster you control; change it to face-up Defense
-- Position, and if you do, its effects are negated unless it is a "Penguin" monster.
-- You can only use each effect of "Penguin Squire" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ペンギン勇士
function c14761450.initial_effect(c)
	--synchro limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetValue(c14761450.synlimit)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(14761450,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_MSET)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,14761450)
	e2:SetCondition(c14761450.spcon1)
	e2:SetTarget(c14761450.sptg)
	e2:SetOperation(c14761450.spop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_CHANGE_POS)
	e3:SetCondition(c14761450.spcon2)
	c:RegisterEffect(e3)
	local e4=e2:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetCondition(c14761450.spcon2)
	c:RegisterEffect(e4)
	--change pos
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(14761450,1))
	e5:SetCategory(CATEGORY_POSITION)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetCountLimit(1,14761451)
	e5:SetTarget(c14761450.postg)
	e5:SetOperation(c14761450.posop)
	c:RegisterEffect(e5)
end
function c14761450.synlimit(e,c)
	if not c then return false end
	return not c:IsAttribute(ATTRIBUTE_WATER)
end
function c14761450.spcon1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsControler,1,nil,tp)
end
function c14761450.cfilter(c,tp)
	return c:IsFacedown() and c:IsControler(tp)
end
function c14761450.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c14761450.cfilter,1,nil,tp)
end
function c14761450.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c14761450.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 and c:IsLevelAbove(2) then
		local off=1
		local ops,opval={},{}
		ops[off]=aux.Stringid(14761450,2)
		opval[off]=-1
		off=off+1
		if c:IsLevelAbove(3) then
			ops[off]=aux.Stringid(14761450,3)
			opval[off]=-2
			off=off+1
		end
		ops[off]=aux.Stringid(14761450,4)
		opval[off]=0
		local op=Duel.SelectOption(tp,table.unpack(ops))+1
		local sel=opval[op]
		if sel==0 then return end
		Duel.BreakEffect()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		e1:SetValue(sel)
		c:RegisterEffect(e1)
	end
end
function c14761450.filter(c)
	return c:IsPosition(POS_FACEDOWN_DEFENSE) and c:IsCanChangePosition()
end
function c14761450.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c14761450.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c14761450.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c14761450.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c14761450.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and not tc:IsPosition(POS_FACEUP_DEFENSE) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)
		if tc:IsPosition(POS_FACEUP_DEFENSE) and not tc:IsSetCard(0x5a) then
			local c=e:GetHandler()
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e1,true)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e2,true)
		end
	end
end
