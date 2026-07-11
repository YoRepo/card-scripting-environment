--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Amazoness Pet Liger  (ID: 68507541)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Beast
-- Level: 7
-- ATK 2500 | DEF 2400
-- Setcode: 0x4
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Amazoness Tiger" + 1 "Amazoness" monster
-- Once per battle, if this card attacks, during damage calculation: You can make this card gain 500
-- ATK during that damage calculation only.
-- If your "Amazoness" monster attacked an opponent's monster, after damage calculation: You can target
-- 1 face-up monster your opponent controls; it loses 800 ATK.
-- Monsters your opponent controls cannot attack "Amazoness" monsters you control, except this one.
--[[ __CARD_HEADER_END__ ]]

--アマゾネスペット虎獅子
function c68507541.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,10979723,aux.FilterBoolFunction(Card.IsFusionSetCard,0x4),1,true,true)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(68507541,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c68507541.atkcon1)
	e1:SetOperation(c68507541.atkop1)
	c:RegisterEffect(e1)
	--atk down
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(68507541,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLED)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(c68507541.atkcon2)
	e2:SetTarget(c68507541.atktg2)
	e2:SetOperation(c68507541.atkop2)
	c:RegisterEffect(e2)
	--atk target
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetValue(c68507541.atktg)
	c:RegisterEffect(e3)
end
function c68507541.atkcon1(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttacker()
end
function c68507541.atkop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(500)
		c:RegisterEffect(e1)
	end
end
function c68507541.atkcon2(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=a:GetBattleTarget()
	return a:IsControler(tp) and a:IsSetCard(0x4)
		and d and d:IsControler(1-tp)
end
function c68507541.atktg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
end
function c68507541.atkop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(-800)
		tc:RegisterEffect(e1)
	end
end
function c68507541.atktg(e,c)
	return c:IsFaceup() and c:IsSetCard(0x4) and c~=e:GetHandler()
end
