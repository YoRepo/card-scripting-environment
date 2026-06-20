--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 月光彩雏  (ID: 35618217)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Beast-Warrior
-- Level 4
-- ATK 1400 | DEF 800
-- Setcode: 223
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：1回合1次，从卡组·额外卡组把1只「月光」怪兽送去墓地才能发动。这个回合，把表侧表示的这张卡作为融合素材的场合，可以作为送去墓地的那只怪兽的同名卡来成为融合素材。
-- ②：这张卡被效果送去墓地的场合，以自己墓地1张「融合」为对象才能发动。那张卡加入手卡。
-- ③：这张卡被除外的场合才能发动。这个回合，对方在战斗阶段中不能把效果发动。
--[[ __CARD_HEADER_END__ ]]

--月光彩雛
function c35618217.initial_effect(c)
	--fusion name
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(35618217,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c35618217.cost)
	e1:SetOperation(c35618217.operation)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(35618217,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,35618217)
	e2:SetCondition(c35618217.thcon)
	e2:SetTarget(c35618217.thtg)
	e2:SetOperation(c35618217.thop)
	c:RegisterEffect(e2)
	--activate limit
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(35618217,2))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_REMOVE)
	e3:SetCondition(aux.bpcon)
	e3:SetOperation(c35618217.actop)
	c:RegisterEffect(e3)
end
function c35618217.costfilter(c,ec)
	return c:IsSetCard(0xdf) and not c:IsFusionCode(ec:GetFusionCode()) and c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c35618217.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c35618217.costfilter,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,nil,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local cg=Duel.SelectMatchingCard(tp,c35618217.costfilter,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,1,nil,c)
	Duel.SendtoGrave(cg,REASON_COST)
	e:SetLabel(cg:GetFirst():GetCode())
end
function c35618217.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ADD_FUSION_CODE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e1:SetValue(e:GetLabel())
	c:RegisterEffect(e1)
end
function c35618217.thcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0
end
function c35618217.thfilter(c)
	return c:IsCode(24094653) and c:IsAbleToHand()
end
function c35618217.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c35618217.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c35618217.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c35618217.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c35618217.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
function c35618217.actop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	e1:SetCondition(c35618217.actcon)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c35618217.actcon(e)
	local ph=Duel.GetCurrentPhase()
	return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE
end
