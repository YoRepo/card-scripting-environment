--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 炎斩机 终末西格马  (ID: 42632209)
-- Type: Monster / Effect / Synchro
-- Attribute: FIRE
-- Race: Cyberse
-- Level 12
-- ATK 3000 | DEF 0
-- Setcode: 306
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这个卡名的③的效果1回合只能使用1次。
-- ①：这张卡只要在额外怪兽区域存在，不受「斩机」卡以外的卡的效果影响。
-- ②：额外怪兽区域的这张卡用和对方怪兽的战斗给与对方的战斗伤害变成2倍。
-- ③：这张卡被战斗或者对方的效果破坏的场合才能发动。从卡组把1张「斩机」卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--炎斬機ファイナルシグマ
function c42632209.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c42632209.imcon)
	e1:SetValue(c42632209.efilter)
	c:RegisterEffect(e1)
	--double battle damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e2:SetCondition(c42632209.damcon)
	e2:SetValue(aux.ChangeBattleDamage(1,DOUBLE_DAMAGE))
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCountLimit(1,42632209)
	e3:SetCondition(c42632209.thcon)
	e3:SetTarget(c42632209.thtg)
	e3:SetOperation(c42632209.thop)
	c:RegisterEffect(e3)
end
function c42632209.imcon(e)
	return e:GetHandler():GetSequence()>4
end
function c42632209.efilter(e,te)
	return not te:GetOwner():IsSetCard(0x132)
end
function c42632209.damcon(e)
	return e:GetHandler():GetBattleTarget()~=nil and e:GetHandler():GetSequence()>4
end
function c42632209.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_BATTLE) or (rp==1-tp and c:IsReason(REASON_EFFECT) and c:IsPreviousControler(tp))
end
function c42632209.thfilter(c)
	return c:IsSetCard(0x132) and c:IsAbleToHand()
end
function c42632209.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c42632209.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c42632209.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c42632209.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
