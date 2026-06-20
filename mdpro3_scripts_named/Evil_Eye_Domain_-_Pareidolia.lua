--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 咒眼领阈-错视之城-  (ID: 70122149)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 297
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：作为这张卡的发动时的效果处理，可以从卡组把1只「咒眼」怪兽加入手卡。
-- ②：1回合1次，自己的魔法与陷阱区域有「太阴之咒眼」存在，自己的「咒眼」怪兽被攻击的伤害计算时才能发动。那次战斗发生的对自己的战斗伤害让对方也承受。
-- ③：场地区域的这张卡被效果破坏的场合，以自己墓地1只「咒眼」怪兽为对象才能发动。那只怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--呪眼領閾－パレイドリア－
function c70122149.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,70122149+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c70122149.activate)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c70122149.rfcon)
	e2:SetTarget(c70122149.rftg)
	e2:SetOperation(c70122149.rfop)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e3:SetCondition(c70122149.thcon)
	e3:SetTarget(c70122149.thtg)
	e3:SetOperation(c70122149.thop)
	c:RegisterEffect(e3)
end
function c70122149.filter(c)
	return c:IsSetCard(0x129) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c70122149.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c70122149.filter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(70122149,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c70122149.filter1(c)
	return c:IsCode(44133040) and c:IsFaceup()
end
function c70122149.rfcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c70122149.filter1,tp,LOCATION_SZONE,0,1,nil)
end
function c70122149.rftg(e,tp,eg,ep,ev,re,r,rp,chk)
	local d=Duel.GetAttackTarget()
	if chk==0 then return d~=nil and d:IsControler(tp) and d:IsSetCard(0x129) end
end
function c70122149.rfop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_ALSO_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c70122149.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_EFFECT) and c:IsPreviousLocation(LOCATION_FZONE)
end
function c70122149.thfilter(c)
	return c:IsSetCard(0x129) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c70122149.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c70122149.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c70122149.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c70122149.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c70122149.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
