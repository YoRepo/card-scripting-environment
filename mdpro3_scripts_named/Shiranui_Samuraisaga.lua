--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 刀神-不知火  (ID: 57288064)
-- Type: Monster / Effect / Synchro
-- Attribute: FIRE
-- Race: Zombie
-- Level 6
-- ATK 2500 | DEF 0
-- Setcode: 217
--
-- Effect Text:
-- 不死族调整＋调整以外的不死族怪兽1只以上
-- 自己对「刀神-不知火」1回合只能有1次特殊召唤。
-- ①：1回合1次，以除外的1只自己的不死族怪兽为对象才能发动。那只怪兽回到卡组，持有那个攻击力以下的攻击力的对方场上的怪兽全部变成守备表示。这个效果在对方回合也能发动。
-- ②：这张卡被除外的场合，以对方场上1只怪兽为对象才能发动。那只怪兽的攻击力下降500。
--[[ __CARD_HEADER_END__ ]]

--刀神－不知火
function c57288064.initial_effect(c)
	c:SetSPSummonOnce(57288064)
	--synchro summon
	aux.AddSynchroProcedure(c,c57288064.synfilter,aux.NonTuner(c57288064.synfilter),1)
	c:EnableReviveLimit()
	--pos
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(57288064,0))
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_POSITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c57288064.postg)
	e1:SetOperation(c57288064.posop)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(57288064,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_REMOVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetTarget(c57288064.target)
	e2:SetOperation(c57288064.operation)
	c:RegisterEffect(e2)
end
function c57288064.synfilter(c)
	return c:IsRace(RACE_ZOMBIE)
end
function c57288064.filter(c,tp)
	local atk=c:GetAttack()
	return c:IsFaceup() and c:IsRace(RACE_ZOMBIE) and atk>=0 and c:IsAbleToDeck()
		and Duel.IsExistingMatchingCard(c57288064.posfilter,tp,0,LOCATION_MZONE,1,nil,atk)
end
function c57288064.posfilter(c,atk)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsCanChangePosition() and c:IsAttackBelow(atk)
end
function c57288064.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_REMOVED) and c57288064.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c57288064.filter,tp,LOCATION_REMOVED,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c57288064.filter,tp,LOCATION_REMOVED,0,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c57288064.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)~=0 then
		local g=Duel.GetMatchingGroup(c57288064.posfilter,tp,0,LOCATION_MZONE,nil,tc:GetAttack())
		Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
	end
end
function c57288064.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
end
function c57288064.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(-500)
		tc:RegisterEffect(e1)
	end
end
