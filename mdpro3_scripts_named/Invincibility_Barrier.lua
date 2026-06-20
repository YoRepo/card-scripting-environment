--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 无敌光环  (ID: 17722185)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：1回合1次，把自己场上1只表侧表示的仪式·融合·同调·超量·灵摆·连接怪兽除外才能发动。这个回合，这张卡在魔法与陷阱区域存在期间，和除外的怪兽相同种类（仪式·融合·同调·超量·灵摆·连接）的怪兽的
-- 效果无效化。
--[[ __CARD_HEADER_END__ ]]

--インヴィンシブル・ヘイロー
function c17722185.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e2:SetCountLimit(1)
	e2:SetCost(c17722185.cost)
	e2:SetOperation(c17722185.operation)
	c:RegisterEffect(e2)
end
function c17722185.cfilter(c)
	return c:IsFaceup() and c:IsType(0x58020C0) and c:IsAbleToRemoveAsCost()
end
function c17722185.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c17722185.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local tc=Duel.SelectMatchingCard(tp,c17722185.cfilter,tp,LOCATION_MZONE,0,1,1,nil):GetFirst()
	Duel.Remove(tc,POS_FACEUP,REASON_COST)
	local flag=0
	if tc:IsType(TYPE_RITUAL) then flag=bit.bor(flag,TYPE_RITUAL) end
	if tc:IsType(TYPE_FUSION) then flag=bit.bor(flag,TYPE_FUSION) end
	if tc:IsType(TYPE_SYNCHRO) then flag=bit.bor(flag,TYPE_SYNCHRO) end
	if tc:IsType(TYPE_XYZ) then flag=bit.bor(flag,TYPE_XYZ) end
	if tc:IsType(TYPE_PENDULUM) then flag=bit.bor(flag,TYPE_PENDULUM) end
	if tc:IsType(TYPE_LINK) then flag=bit.bor(flag,TYPE_LINK) end
	e:SetLabel(flag)
end
function c17722185.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:RegisterFlagEffect(17722185,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
	local flag=e:GetLabel()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c17722185.distg)
	e1:SetCondition(c17722185.discon)
	e1:SetLabel(flag)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c17722185.distg(e,c)
	return c:IsType(e:GetLabel())
end
function c17722185.discon(e)
	return e:GetHandler():GetFlagEffect(17722185)~=0
end
