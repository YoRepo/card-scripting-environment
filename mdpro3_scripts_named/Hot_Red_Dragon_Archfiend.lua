--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 琰魔龙 红莲魔  (ID: 39765958)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Dragon
-- Level 8
-- ATK 3000 | DEF 2000
-- Setcode: 4165
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 1回合1次，自己的主要阶段1才能发动。这张卡以外的场上表侧攻击表示存在的怪兽全部破坏。这个效果发动的回合，这张卡以外的怪兽不能攻击。
--[[ __CARD_HEADER_END__ ]]

--琰魔竜 レッド・デーモン
function c39765958.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetDescription(aux.Stringid(39765958,0))
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c39765958.descon)
	e1:SetCost(c39765958.descost)
	e1:SetTarget(c39765958.destg)
	e1:SetOperation(c39765958.desop)
	c:RegisterEffect(e1)
end
function c39765958.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
end
function c39765958.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_OATH)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c39765958.ftarget)
	e1:SetLabel(e:GetHandler():GetFieldID())
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c39765958.ftarget(e,c)
	return e:GetLabel()~=c:GetFieldID()
end
function c39765958.dfilter(c)
	return c:IsPosition(POS_FACEUP_ATTACK)
end
function c39765958.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c39765958.dfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) end
	local sg=Duel.GetMatchingGroup(c39765958.dfilter,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c39765958.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c39765958.dfilter,tp,LOCATION_MZONE,LOCATION_MZONE,aux.ExceptThisCard(e))
	Duel.Destroy(sg,REASON_EFFECT)
end
