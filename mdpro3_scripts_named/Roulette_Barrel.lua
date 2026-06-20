--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 轮盘炸弹  (ID: 46303688)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level 4
-- ATK 1000 | DEF 2000
--
-- Effect Text:
-- 在自己的每回合的主要阶段可以掷2次骰子，在掷出的点数中选择1个，破坏场上1只表侧表示的与此点数相同等级的怪兽。
--[[ __CARD_HEADER_END__ ]]

--ルーレットボマー
function c46303688.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(46303688,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DICE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c46303688.target)
	e1:SetOperation(c46303688.activate)
	c:RegisterEffect(e1)
end
function c46303688.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,2)
end
function c46303688.dfilter(c,lv)
	return c:IsFaceup() and c:IsLevel(lv)
end
function c46303688.activate(e,tp,eg,ep,ev,re,r,rp)
	local d1,d2=Duel.TossDice(tp,2)
	local sel=d1
	if d1>d2 then d1,d2=d2,d1 end
	if d1~=d2 then
		sel=Duel.AnnounceNumber(tp,d1,d2)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local dg=Duel.SelectMatchingCard(tp,c46303688.dfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,sel)
	if dg:GetCount()>0 then
		Duel.Destroy(dg,REASON_EFFECT)
	end
end
