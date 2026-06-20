--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 超能破坏者  (ID: 11232355)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Psychic
-- Level 4
-- ATK 1600 | DEF 400
--
-- Effect Text:
-- 支付1000基本分才能发动。选择对方场上盖放的1张魔法·陷阱卡破坏。此外，双方的结束阶段时，自己场上没有这张卡以外的念动力族怪兽存在的场合，这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--ディストラクター
function c11232355.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11232355,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCost(c11232355.descost)
	e1:SetTarget(c11232355.destg)
	e1:SetOperation(c11232355.desop)
	c:RegisterEffect(e1)
	--self destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(11232355,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c11232355.sdcon)
	e2:SetTarget(c11232355.sdtg)
	e2:SetOperation(c11232355.sdop)
	c:RegisterEffect(e2)
end
function c11232355.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c11232355.filter(c)
	return c:IsFacedown()
end
function c11232355.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(1-tp) and c11232355.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c11232355.filter,tp,0,LOCATION_SZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c11232355.filter,tp,0,LOCATION_SZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c11232355.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c11232355.cfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_PSYCHO)
end
function c11232355.sdcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c11232355.cfilter,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c11232355.sdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c11232355.sdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.Destroy(c,REASON_EFFECT)
	end
end
