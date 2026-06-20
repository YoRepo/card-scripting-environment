--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 命运之里宝牌  (ID: 27753563)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：支付1000基本分，以自己场上1只表侧表示怪兽为对象才能发动。直到对方回合结束时，那只怪兽的攻击力上升1000，以下效果适用。
-- ●那只怪兽战斗破坏对方怪兽时才能发动。自己卡组最下面的卡给双方确认，回到卡组最上面或者最下面。确认的卡是龙族·恐龙族·海龙族·幻龙族怪兽的场合，那个攻击力每有1000，自己从卡组抽1张。那之后，自己回
-- 复抽出数量×1000基本分。
--[[ __CARD_HEADER_END__ ]]

--運命のウラドラ
function c27753563.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCost(c27753563.cost)
	e1:SetTarget(c27753563.target)
	e1:SetOperation(c27753563.operation)
	c:RegisterEffect(e1)
end
function c27753563.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c27753563.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end
function c27753563.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetDescription(aux.Stringid(27753563,0))
		e2:SetCategory(CATEGORY_RECOVER+CATEGORY_DRAW)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
		e2:SetCode(EVENT_BATTLE_DESTROYING)
		e2:SetLabelObject(tc)
		e2:SetCondition(c27753563.cmcon)
		e2:SetTarget(c27753563.cmtg)
		e2:SetOperation(c27753563.cmop)
		e2:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		Duel.RegisterEffect(e2,tp)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EFFECT_DESTROY_REPLACE)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCondition(c27753563.regcon)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		tc:RegisterEffect(e3)
	end
end
function c27753563.regcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetBattleTarget() and r==REASON_BATTLE then
		c:RegisterFlagEffect(27753563,RESET_PHASE+PHASE_DAMAGE,0,1)
	end
	return false
end
function c27753563.cmcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return eg:IsContains(tc) and tc:GetFlagEffect(27753563)~=0
end
function c27753563.cmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function c27753563.cmop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_DECK,0)
	if g:GetCount()==0 then return end
	local tc=g:GetMinGroup(Card.GetSequence):GetFirst()
	Duel.MoveSequence(tc,SEQ_DECKTOP)
	Duel.ConfirmDecktop(tp,1)
	local opt=Duel.SelectOption(tp,aux.Stringid(27753563,1),aux.Stringid(27753563,2))
	Duel.MoveSequence(tc,opt)
	if tc:IsRace(RACE_DRAGON) or tc:IsRace(RACE_DINOSAUR) or tc:IsRace(RACE_SEASERPENT) or tc:IsRace(RACE_WYRM) then
		local d=math.floor(tc:GetAttack()/1000)
		local dn=Duel.Draw(tp,d,REASON_EFFECT)
		if dn>0 then
			Duel.BreakEffect()
			Duel.Recover(tp,dn*1000,REASON_EFFECT)
		end
	end
end
