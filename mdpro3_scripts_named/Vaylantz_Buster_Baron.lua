--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Vaylantz Buster Baron  (ID: 14418464)
-- Type: Monster / Effect / Pendulum
-- Attribute: FIRE
-- Race: Machine
-- Level: 2
-- ATK 800 | DEF 800
-- Pendulum Scale: L1 / R1
-- Setcode: 0x17d
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 1
-- [ Pendulum Effect ]
-- During your Main Phase: You can Special Summon this card to your Main Monster Zone in its same
-- column, also you cannot Special Summon non-"Vaylantz" monsters for the rest of this turn, except
-- from the Extra Deck.
-- You can only use this effect of "Vaylantz Buster Baron" once per turn.
-- ----------------------------------------
-- [ Monster Effect ]
-- If you control this Special Summoned card: You can target 1 other "Vaylantz" monster in your Main
-- Monster Zone; move that monster you control to an adjacent (horizontal)
-- Monster Zone.
-- If this card in the Monster Zone moves to another Monster Zone: You can target 1 card in either
-- player's Pendulum Zone; place it face-up in its adjacent Spell & Trap Zone as a Continuous Spell.
-- You can only use each effect of "Vaylantz Buster Baron" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ヴァリアンツB－バロン
function c14418464.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,14418464)
	e1:SetTarget(c14418464.sptg)
	e1:SetOperation(c14418464.spop)
	c:RegisterEffect(e1)
	--move
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,14418465)
	e2:SetCondition(c14418464.seqcon)
	e2:SetTarget(c14418464.seqtg)
	e2:SetOperation(c14418464.seqop)
	c:RegisterEffect(e2)
	--move
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_MOVE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,14418466)
	e3:SetCondition(c14418464.mvcon)
	e3:SetTarget(c14418464.mvtg)
	e3:SetOperation(c14418464.mvop)
	c:RegisterEffect(e3)
end
function c14418464.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local zone=1<<c:GetSequence()
	if chk==0 then return c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp,zone) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c14418464.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local zone=1<<c:GetSequence()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP,zone)
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c14418464.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c14418464.splimit(e,c)
	return not c:IsSetCard(0x17d) and not c:IsLocation(LOCATION_EXTRA)
end
function c14418464.seqcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SPECIAL)
end
function c14418464.filter(c)
	local seq=c:GetSequence()
	local tp=c:GetControler()
	if seq>4 or not c:IsSetCard(0x17d) or c:IsFacedown() then return false end
	return (seq>0 and Duel.CheckLocation(tp,LOCATION_MZONE,seq-1))
		or (seq<4 and Duel.CheckLocation(tp,LOCATION_MZONE,seq+1))
end
function c14418464.seqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c14418464.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c14418464.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(14418464,0))
	Duel.SelectTarget(tp,c14418464.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
end
function c14418464.seqop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local seq=tc:GetSequence()
	if seq>4 then return end
	local flag=0
	if seq>0 and Duel.CheckLocation(tp,LOCATION_MZONE,seq-1) then flag=flag|(1<<(seq-1)) end
	if seq<4 and Duel.CheckLocation(tp,LOCATION_MZONE,seq+1) then flag=flag|(1<<(seq+1)) end
	if flag==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOZONE)
	local s=Duel.SelectField(tp,1,LOCATION_MZONE,0,~flag)
	local nseq=math.log(s,2)
	Duel.MoveSequence(tc,nseq)
end
function c14418464.mvcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsLocation(LOCATION_MZONE)
		and (c:GetPreviousSequence()~=c:GetSequence() or c:GetPreviousControler()~=tp)
end
function c14418464.mvfilter(c)
	local seq=c:GetSequence()
	local tp=c:GetControler()
	return (seq==0 and Duel.CheckLocation(tp,LOCATION_SZONE,1))
		or (seq==4 and Duel.CheckLocation(tp,LOCATION_SZONE,3))
end
function c14418464.mvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_PZONE) and c14418464.mvfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c14418464.mvfilter,tp,LOCATION_PZONE,LOCATION_PZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(14418464,1))
	Duel.SelectTarget(tp,c14418464.mvfilter,tp,LOCATION_PZONE,LOCATION_PZONE,1,1,nil)
end
function c14418464.mvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local seq=tc:GetSequence()
	if not seq==0 and not seq==4 then return end
	local nseq=0
	if seq==0 then nseq=1 end
	if seq==4 then nseq=3 end
	if Duel.MoveToField(tc,tp,tc:GetControler(),LOCATION_SZONE,POS_FACEUP,true,1<<nseq) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
		e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		tc:RegisterEffect(e1)
	end
end
