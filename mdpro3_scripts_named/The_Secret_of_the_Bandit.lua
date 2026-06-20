--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 盗贼的极意  (ID: 99351431)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 只能在主要阶段一发动。选择场上的1只表侧表示存在的怪兽。在这个回合，选择的怪兽每次给与对方玩家战斗伤害，对方随机丢弃1张手卡。
--[[ __CARD_HEADER_END__ ]]

--盗賊の極意
function c99351431.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c99351431.target)
	e1:SetOperation(c99351431.activate)
	c:RegisterEffect(e1)
end
function c99351431.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.GetCurrentPhase()==PHASE_MAIN1
		and Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c99351431.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsImmuneToEffect(e) and tc:GetFlagEffect(99351431)==0 then
		tc:RegisterFlagEffect(99351431,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(99351431,0))
		e1:SetCategory(CATEGORY_HANDES)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e1:SetCode(EVENT_BATTLE_DAMAGE)
		e1:SetLabelObject(tc)
		e1:SetCondition(c99351431.hdcon)
		e1:SetTarget(c99351431.hdtg)
		e1:SetOperation(c99351431.hdop)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
end
function c99351431.hdcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==1-tp and eg:GetFirst()==e:GetLabelObject() and eg:GetFirst():GetFlagEffect(99351431)~=0
end
function c99351431.hdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
end
function c99351431.hdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND):RandomSelect(tp,1)
	Duel.SendtoGrave(g,REASON_EFFECT+REASON_COST)
end
