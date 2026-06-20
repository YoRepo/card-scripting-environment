--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 银河卫龙  (ID: 92362073)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Dragon
-- ATK 2000 | LINK
-- Setcode: 123
--
-- Effect Text:
-- 龙族怪兽2只
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己·对方的战斗阶段，把场上·墓地的这张卡除外，以自己场上1只原本的种族·属性是龙族·光属性的「No.」超量怪兽为对象才能发动。直到战斗阶段结束时，对方受到的战斗伤害变成一半，作为对象的怪兽的攻击
-- 力变成那只怪兽持有的「No.」数值×100。
-- ②：对方结束阶段才能发动。从卡组选1张卡在卡组最上面放置。
--[[ __CARD_HEADER_END__ ]]

--銀河衛竜
function c92362073.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_DRAGON),2,2)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(92362073,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_GRAVE+LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,92362073)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c92362073.atkcon)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c92362073.atktg)
	e1:SetOperation(c92362073.atkop)
	c:RegisterEffect(e1)
	--deck top
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(92362073,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1,92362074)
	e2:SetCondition(c92362073.tpcon)
	e2:SetTarget(c92362073.tptg)
	e2:SetOperation(c92362073.tpop)
	c:RegisterEffect(e2)
end
function c92362073.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE
end
function c92362073.atkfilter(c)
	local no=aux.GetXyzNumber(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x48) and no
		and c:GetOriginalAttribute()==ATTRIBUTE_LIGHT and c:GetOriginalRace()==RACE_DRAGON
end
function c92362073.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c92362073.atkfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c92362073.atkfilter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c92362073.atkfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c92362073.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local no=aux.GetXyzNumber(tc)
	if no and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(no*100)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE)
		tc:RegisterEffect(e1)
	end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(0,1)
	e2:SetValue(HALF_DAMAGE)
	e2:SetReset(RESET_PHASE+PHASE_BATTLE)
	Duel.RegisterEffect(e2,tp)
end
function c92362073.tpcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c92362073.tptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_DECK,0,1,nil)
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>1 end
end
function c92362073.tpop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(92362073,2))
	local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.ShuffleDeck(tp)
		Duel.MoveSequence(tc,SEQ_DECKTOP)
	end
end
