--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 义贼的极意书  (ID: 95096437)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 选择自己场上表侧表示存在的1只通常怪兽发动。这个回合选择怪兽给与对方基本分战斗伤害时，对方随机丢弃2张手卡。
--[[ __CARD_HEADER_END__ ]]

--義賊の極意書
function c95096437.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c95096437.target)
	e1:SetOperation(c95096437.activate)
	c:RegisterEffect(e1)
end
function c95096437.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_NORMAL)
end
function c95096437.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c95096437.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c95096437.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c95096437.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c95096437.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsImmuneToEffect(e) then
		tc:RegisterFlagEffect(95096437,RESET_EVENT+0x1220000+RESET_PHASE+PHASE_END,0,1)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(95096437,0))
		e1:SetCategory(CATEGORY_HANDES)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e1:SetCode(EVENT_BATTLE_DAMAGE)
		e1:SetLabelObject(tc)
		e1:SetCondition(c95096437.hdcon)
		e1:SetTarget(c95096437.hdtg)
		e1:SetOperation(c95096437.hdop)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
end
function c95096437.hdcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return ep~=tp and eg:IsContains(tc) and tc:GetFlagEffect(95096437)~=0
end
function c95096437.hdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,1-tp,2)
end
function c95096437.hdop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetFieldGroup(p,0,LOCATION_HAND)
	local dg=g:RandomSelect(tp,2)
	Duel.SendtoGrave(dg,REASON_EFFECT+REASON_DISCARD)
end
