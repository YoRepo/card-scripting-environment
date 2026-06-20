--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:29
-- Card: 朔夜时雨  (ID: 52038441)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Zombie
-- Level 3
-- ATK 0 | DEF 1800
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：对方把怪兽表侧表示特殊召唤的场合，把这张卡从手卡丢弃，以那些表侧表示怪兽之内的1只为对象才能发动。那只怪兽的效果直到回合结束时无效化，这个回合中作为对象的表侧表示怪兽从场上离开时那个控制者受到作为
-- 对象的怪兽的原本攻击力数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--朔夜しぐれ
function c52038441.initial_effect(c)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(52038441,0))
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_CUSTOM+52038441)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,52038441)
	e1:SetCondition(c52038441.discon)
	e1:SetCost(c52038441.discost)
	e1:SetTarget(c52038441.distg)
	e1:SetOperation(c52038441.disop)
	c:RegisterEffect(e1)
	aux.RegisterMergedDelayedEvent(c,52038441,EVENT_SPSUMMON_SUCCESS)
end
function c52038441.cfilter(c,tp)
	return c:IsFaceup() and c:IsSummonPlayer(1-tp) and (aux.NegateMonsterFilter(c) or c:GetAttack()>0)
end
function c52038441.discon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c52038441.cfilter,1,nil,tp)
end
function c52038441.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c52038441.disfilter(c,g)
	return g:IsContains(c)
end
function c52038441.distg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=eg:Filter(c52038441.cfilter,nil,tp)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c52038441.disfilter(chkc,g) end
	if chk==0 then return Duel.IsExistingTarget(c52038441.disfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,g) end
	if g:GetCount()==1 then
		Duel.SetTargetCard(g)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		Duel.SelectTarget(tp,c52038441.disfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,g)
	end
end
function c52038441.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		local fid=c:GetFieldID()
		tc:RegisterFlagEffect(52038441,RESET_EVENT+RESET_TURN_SET+RESET_OVERLAY+RESET_MSCHANGE+RESET_PHASE+PHASE_END,EFFECT_FLAG_CLIENT_HINT,1,fid,aux.Stringid(52038441,1))
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EVENT_LEAVE_FIELD)
		e3:SetLabel(fid)
		e3:SetLabelObject(tc)
		e3:SetReset(RESET_PHASE+PHASE_END)
		e3:SetOperation(c52038441.damop)
		Duel.RegisterEffect(e3,tp)
	end
end
function c52038441.damop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if not eg:IsContains(tc) then return end
	if tc:GetFlagEffectLabel(52038441)~=e:GetLabel() then
		e:Reset()
		return
	end
	Duel.Hint(HINT_CARD,0,52038441)
	Duel.Damage(tc:GetPreviousControler(),tc:GetBaseAttack(),REASON_EFFECT)
	tc:ResetFlagEffect(52038441)
	e:Reset()
end
