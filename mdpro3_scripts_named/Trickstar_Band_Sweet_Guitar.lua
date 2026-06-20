--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 淘气仙星乐队·吉她斯薇特  (ID: 91272072)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Fairy
-- Level 7
-- ATK 2200 | DEF 1200
-- Setcode: 251
--
-- Effect Text:
-- 「淘气仙星」连接怪兽＋「淘气仙星」怪兽
-- ①：和这张卡连接状态的自己的「淘气仙星」连接怪兽的效果给与对方的伤害变成2倍。
-- ②：每次「淘气仙星」怪兽的效果让对方受到伤害发动。这张卡的攻击力上升那次伤害的数值。
-- ③：这张卡攻击的回合的结束阶段发动。这张卡的②的效果上升的数值回到0。那之后，可以从自己墓地选1只「淘气仙星」怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--トリックスターバンド・ギタースイート
function c91272072.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0xfb),c91272072.matfilter,true)
	--avoid damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetValue(c91272072.damval)
	c:RegisterEffect(e1)
	--gain atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(91272072,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_DAMAGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c91272072.atkcon)
	e2:SetOperation(c91272072.atkop)
	c:RegisterEffect(e2)
	--recycle
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(91272072,1))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetLabelObject(e2)
	e3:SetCondition(c91272072.condition)
	e3:SetTarget(c91272072.target)
	e3:SetOperation(c91272072.operation)
	c:RegisterEffect(e3)
end
function c91272072.matfilter(c)
	return c:IsFusionType(TYPE_LINK) and c:IsFusionSetCard(0xfb)
end
function c91272072.damval(e,re,val,r,rp)
	if r&REASON_EFFECT==REASON_EFFECT and re and re:IsActiveType(TYPE_MONSTER) then
		local rc=re:GetHandler()
		if rc:IsFaceup() and rc:IsSetCard(0xfb) and rc:IsType(TYPE_LINK)
			and rc:GetLinkedGroup():IsContains(e:GetHandler()) then
			return val*2
		end
	end
	return val
end
function c91272072.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and r&REASON_EFFECT==REASON_EFFECT and re:IsActiveType(TYPE_MONSTER) and re:GetHandler():IsSetCard(0xfb)
end
function c91272072.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetLabelObject(e)
		e1:SetValue(ev)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
function c91272072.thfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0xfb) and c:IsAbleToHand()
end
function c91272072.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetAttackedCount()>0
end
function c91272072.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE)
end
function c91272072.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local chk=false
		local effs={c:IsHasEffect(EFFECT_UPDATE_ATTACK)}
		for _,eff in ipairs(effs) do
			if eff:GetLabelObject()==e:GetLabelObject() then
				eff:Reset()
				chk=true
			end
		end
		local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c91272072.thfilter),tp,LOCATION_GRAVE,0,nil)
		if chk and #g>0 and Duel.SelectYesNo(tp,aux.Stringid(91272072,2)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=g:Select(tp,1,1,nil)
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
		end
	end
end
