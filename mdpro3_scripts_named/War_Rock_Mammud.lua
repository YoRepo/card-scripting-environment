--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: War Rock Mammud  (ID: 84903021)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 5
-- ATK 2000 | DEF 2000
-- Setcode: 0x15f
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control no monsters, or all monsters you control are Warrior monsters, you can Normal Summon
-- this card without Tributing.
-- If your EARTH Warrior monster battles, after damage calculation: You can target 1 Spell/Trap your
-- opponent controls; destroy it, then all "War Rock" monsters you currently control gain 200 ATK until
-- the end of your opponent's turn.
-- You can only use this effect of "War Rock Mammud" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ウォークライ・マムード
function c84903021.initial_effect(c)
	--Tribute Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(84903021,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c84903021.tscon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--ATK UP
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(84903021,1))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_BATTLED)
	e2:SetCountLimit(1,84903021)
	e2:SetTarget(c84903021.dstg)
	e2:SetOperation(c84903021.dsop)
	c:RegisterEffect(e2)
end
function c84903021.cfilter(c)
	return c:IsFacedown() or not c:IsRace(RACE_WARRIOR)
end
function c84903021.tscon(e,c,minc)
	if c==nil then return true end
	local tp=c:GetControler()
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and (Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0 or not Duel.IsExistingMatchingCard(c84903021.cfilter,tp,LOCATION_MZONE,0,1,nil))
end
function c84903021.check(c,tp)
	return c and c:IsControler(tp) and c:IsRace(RACE_WARRIOR) and c:IsAttribute(ATTRIBUTE_EARTH)
end
function c84903021.dstg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsOnField() and chkc:IsType(TYPE_SPELL+TYPE_TRAP) end
	if chk==0 then return (c84903021.check(Duel.GetAttacker(),tp) or c84903021.check(Duel.GetAttackTarget(),tp))
		and Duel.IsExistingTarget(Card.IsType,tp,0,LOCATION_ONFIELD,1,nil,TYPE_SPELL+TYPE_TRAP)
		and Duel.IsExistingMatchingCard(c84903021.atkfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsType,tp,0,LOCATION_ONFIELD,1,1,nil,TYPE_SPELL+TYPE_TRAP)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c84903021.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x15f) and not c:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c84903021.dsop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)>0 then
		Duel.BreakEffect()
		local ag=Duel.GetMatchingGroup(c84903021.atkfilter,tp,LOCATION_MZONE,0,nil)
		for tc2 in aux.Next(ag) do
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
			e1:SetValue(200)
			tc2:RegisterEffect(e1)
		end
	end
end
