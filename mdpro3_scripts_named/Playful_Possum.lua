--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 装傻负鼠  (ID: 69529567)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 2
-- ATK 800 | DEF 600
--
-- Effect Text:
-- 自己的主要阶段时，持有比这张卡的攻击力高的攻击力的怪兽在对方场上表侧表示存在的场合，可以把场上存在的这张卡破坏。此外，自己的准备阶段时，这张卡的效果破坏的这张卡可以从墓地特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--おとぼけオポッサム
function c69529567.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(69529567,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c69529567.descon)
	e1:SetTarget(c69529567.destg)
	e1:SetOperation(c69529567.desop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(69529567,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1)
	e2:SetCondition(c69529567.spcon)
	e2:SetTarget(c69529567.sptg)
	e2:SetOperation(c69529567.spop)
	c:RegisterEffect(e2)
end
function c69529567.desfilter(c,atk)
	return c:IsFaceup() and c:GetAttack()>atk
end
function c69529567.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c69529567.desfilter,tp,0,LOCATION_MZONE,1,nil,e:GetHandler():GetAttack())
end
function c69529567.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsLocation(LOCATION_ONFIELD) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c69529567.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.Destroy(e:GetHandler(),REASON_EFFECT)~=0 then
		e:GetHandler():RegisterFlagEffect(69529567,RESET_EVENT+RESETS_STANDARD,0,1)
	end
end
function c69529567.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c69529567.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(69529567)~=0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c69529567.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
