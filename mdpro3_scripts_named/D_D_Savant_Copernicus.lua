--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: DD 魔导贤者 哥白尼  (ID: 46796664)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Fiend
-- Level 4
-- Pendulum Scales: L1 / R1
-- ATK 0 | DEF 0
-- Setcode: 7209135
--
-- Effect Text:
-- ←1 【灵摆】 1→
-- ①：自己不是「DD」怪兽不能灵摆召唤。这个效果不会被无效化。
-- ②：只在这张卡在灵摆区域存在才有1次，给与自己伤害的魔法卡的效果的处理时，可以把那个效果无效。那之后，这张卡破坏。
-- 【怪兽效果】
-- 这个卡名的怪兽效果1回合只能使用1次。
-- ①：这张卡召唤·特殊召唤的场合才能发动。除「DD 魔导贤者 哥白尼」外的1张「DD」卡或「契约书」卡从卡组送去墓地。
--[[ __CARD_HEADER_END__ ]]

--DD魔導賢者コペルニクス
function c46796664.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CAN_FORBIDDEN)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c46796664.splimit)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetCondition(c46796664.discon)
	e2:SetOperation(c46796664.disop)
	c:RegisterEffect(e2)
	--send to grave
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(46796664,0))
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetCountLimit(1,46796664)
	e3:SetTarget(c46796664.tgtg)
	e3:SetOperation(c46796664.tgop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
end
function c46796664.splimit(e,c,sump,sumtype,sumpos,targetp)
	return not c:IsSetCard(0xaf) and bit.band(sumtype,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c46796664.discon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsChainNegatable(ev) and not Duel.IsChainDisabled(ev)
		and re:IsActiveType(TYPE_SPELL) and aux.damcon1(e,tp,eg,ep,ev,re,r,rp) and e:GetHandler():GetFlagEffect(46796664)==0
end
function c46796664.disop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.SelectEffectYesNo(tp,e:GetHandler()) then return end
	e:GetHandler():RegisterFlagEffect(46796664,RESET_EVENT+RESETS_STANDARD,0,1)
	if not Duel.NegateEffect(ev) then return end
	Duel.BreakEffect()
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c46796664.tgfilter(c)
	return c:IsSetCard(0xaf,0xae) and not c:IsCode(46796664) and c:IsAbleToGrave()
end
function c46796664.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c46796664.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c46796664.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c46796664.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
