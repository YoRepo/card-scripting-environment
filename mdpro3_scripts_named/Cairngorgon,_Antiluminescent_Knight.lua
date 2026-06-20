--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 暗迁士 黑蛇晶  (ID: 21501505)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Rock
-- Rank 4
-- ATK 2450 | DEF 1950
--
-- Effect Text:
-- 4星怪兽×2
-- ①：只以场上的卡1张为对象的其他的魔法·陷阱·怪兽的效果发动时，把这张卡1个超量素材取除，以场上1张作为正确对象的别的卡为对象才能发动。那个效果的对象转移为作为正确对象的那张卡。
--[[ __CARD_HEADER_END__ ]]

--暗遷士 カンゴルゴーム
function c21501505.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--replace
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21501505,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c21501505.condition)
	e1:SetCost(c21501505.cost)
	e1:SetTarget(c21501505.target)
	e1:SetOperation(c21501505.operation)
	c:RegisterEffect(e1)
end
function c21501505.condition(e,tp,eg,ep,ev,re,r,rp)
	if e==re or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or g:GetCount()~=1 then return false end
	local tc=g:GetFirst()
	e:SetLabelObject(tc)
	return tc:IsOnField()
end
function c21501505.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c21501505.filter(c,ct)
	return Duel.CheckChainTarget(ct,c)
end
function c21501505.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ct=ev
	local label=Duel.GetFlagEffectLabel(0,21501505)
	if label then
		if ev==bit.rshift(label,16) then ct=bit.band(label,0xffff) end
	end
	if chkc then return chkc:IsOnField() and c21501505.filter(chkc,ct) end
	if chk==0 then return Duel.IsExistingTarget(c21501505.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetLabelObject(),ct) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c21501505.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetLabelObject(),ct)
	local val=ct+bit.lshift(ev+1,16)
	if label then
		Duel.SetFlagEffectLabel(0,21501505,val)
	else
		Duel.RegisterFlagEffect(0,21501505,RESET_CHAIN,0,1,val)
	end
end
function c21501505.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.ChangeTargetCard(ev,Group.FromCards(tc))
	end
end
