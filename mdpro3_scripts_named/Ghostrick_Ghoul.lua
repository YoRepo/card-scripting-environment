--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 鬼计食尸鬼  (ID: 85463083)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 3
-- ATK 1100 | DEF 1200
-- Setcode: 141
--
-- Effect Text:
-- 自己场上有「鬼计」怪兽存在的场合才能让这张卡表侧表示召唤。
-- ①：自己主要阶段才能发动。这张卡变成里侧守备表示（1回合只有1次）。
-- ②：自己主要阶段1有1次，以自己场上1只「鬼计」怪兽为对象才能发动。那只怪兽的攻击力直到下次的对方回合的结束时变成场上的「鬼计」怪兽的原本攻击力合计数值，这个回合作为对象的怪兽以外的怪兽不能攻击。
--[[ __CARD_HEADER_END__ ]]

--ゴーストリック・グール
function c85463083.initial_effect(c)
	--summon limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetCondition(c85463083.sumcon)
	c:RegisterEffect(e1)
	--turn set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(85463083,0))
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c85463083.postg)
	e2:SetOperation(c85463083.posop)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(85463083,1))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c85463083.atkcon)
	e3:SetTarget(c85463083.atktg)
	e3:SetOperation(c85463083.atkop)
	c:RegisterEffect(e3)
end
function c85463083.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x8d)
end
function c85463083.sumcon(e)
	return not Duel.IsExistingMatchingCard(c85463083.filter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c85463083.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanTurnSet() and c:GetFlagEffect(85463083)==0 end
	c:RegisterFlagEffect(85463083,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,c,1,0,0)
end
function c85463083.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)
	end
end
function c85463083.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
end
function c85463083.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c85463083.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c85463083.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c85463083.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_OATH)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c85463083.ftarget)
	e1:SetLabel(g:GetFirst():GetFieldID())
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c85463083.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local atk=0
		local g=Duel.GetMatchingGroup(c85463083.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
		local bc=g:GetFirst()
		while bc do
			local catk=bc:GetBaseAttack()
			if catk<0 then catk=0 end
			atk=atk+catk
			bc=g:GetNext()
		end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
		tc:RegisterEffect(e1)
	end
end
function c85463083.ftarget(e,c)
	return e:GetLabel()~=c:GetFieldID()
end
