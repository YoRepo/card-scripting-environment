--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 二进制女巫  (ID: 79016563)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Cyberse
-- ATK 1600 | LINK
--
-- Effect Text:
-- 衍生物以外的怪兽2只
-- ①：得到和这张卡互相连接的怪兽数量的以下效果。
-- ●1只以上：和这张卡互相连接的怪兽用和对方怪兽的战斗给与对方战斗伤害时才能发动。自己基本分回复那个数值。
-- ●2只：1回合1次，以自己场上2只表侧表示怪兽为对象才能发动。直到回合结束时，那2只怪兽之内1只的攻击力变成一半，另1只的攻击力上升那个数值。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--バイナル・ソーサレス
function c79016563.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,c79016563.matfilter,2,2)
	c:EnableReviveLimit()
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(79016563,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c79016563.reccon)
	e1:SetTarget(c79016563.rectg)
	e1:SetOperation(c79016563.recop)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(79016563,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c79016563.atkcon)
	e2:SetTarget(c79016563.atktg)
	e2:SetOperation(c79016563.atkop)
	c:RegisterEffect(e2)
end
function c79016563.matfilter(c)
	return not c:IsLinkType(TYPE_TOKEN)
end
function c79016563.reccon(e,tp,eg,ep,ev,re,r,rp)
	local lg=e:GetHandler():GetMutualLinkedGroup()
	local tc=eg:GetFirst()
	return ep~=tp and lg:IsContains(tc) and tc:GetBattleTarget()~=nil
end
function c79016563.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(ev)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,ev)
end
function c79016563.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
function c79016563.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return aux.dscon(e,tp,eg,ep,ev,re,r,rp)
		and e:GetHandler():GetMutualLinkedGroupCount()>=2
end
function c79016563.tgfilter(c,e)
	return c:IsFaceup() and c:IsCanBeEffectTarget(e)
end
function c79016563.gcheck(g)
	return g:IsExists(Card.IsAttackAbove,1,nil,1)
end
function c79016563.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local g=Duel.GetMatchingGroup(c79016563.tgfilter,tp,LOCATION_MZONE,0,nil,e)
	if chk==0 then return g:CheckSubGroup(c79016563.gcheck,2,2) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local sg=g:SelectSubGroup(tp,c79016563.gcheck,false,2,2)
	Duel.SetTargetCard(sg)
end
function c79016563.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetTargetsRelateToChain()
	if g:FilterCount(Card.IsFaceup,nil)<2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(79016563,2))
	local tc1=g:FilterSelect(tp,Card.IsAttackAbove,1,1,nil,1):GetFirst()
	local tc2=(g-tc1):GetFirst()
	local atk=tc1:GetAttack()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e1:SetValue(math.ceil(atk/2))
	if tc1:RegisterEffect(e1) then
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e2:SetValue(math.ceil(atk/2))
		tc2:RegisterEffect(e2)
	end
end
