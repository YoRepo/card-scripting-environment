--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 妖仙兽 木魅  (ID: 23740893)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Beast-Warrior
-- Level 1
-- ATK 0 | DEF 0
-- Setcode: 179
--
-- Effect Text:
-- 「妖仙兽 木魅」的①的效果1回合只能使用1次。
-- ①：把这张卡解放，以自己场上1张「修验的妖社」为对象才能发动。给那张卡放置3个妖仙指示物。
-- ②：自己主要阶段把墓地的这张卡除外才能发动。这个回合，自己在通常召唤外加上只有1次，自己主要阶段可以把1只「妖仙兽」怪兽召唤。
--[[ __CARD_HEADER_END__ ]]

--妖仙獣 木魅
function c23740893.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,23740893)
	e1:SetCost(c23740893.cost)
	e1:SetTarget(c23740893.target)
	e1:SetOperation(c23740893.activate)
	c:RegisterEffect(e1)
	--extra summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c23740893.sumtg)
	e2:SetOperation(c23740893.sumop)
	c:RegisterEffect(e2)
end
function c23740893.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c23740893.filter(c)
	return c:IsFaceup() and c:IsCode(27918963) and c:IsCanAddCounter(0x33,3)
end
function c23740893.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsOnField() and c23740893.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c23740893.filter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(23740893,0))
	Duel.SelectTarget(tp,c23740893.filter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,3,0,0x33)
end
function c23740893.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		tc:AddCounter(0x33,3)
	end
end
function c23740893.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanSummon(tp) and Duel.IsPlayerCanAdditionalSummon(tp) and Duel.GetFlagEffect(tp,23740893)==0 end
end
function c23740893.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,23740893)~=0 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(23740893,1))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xb3))
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,23740893,RESET_PHASE+PHASE_END,0,1)
end
