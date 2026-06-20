--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: No.72 行列怪兽 战车之飞车  (ID: 75253697)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Rank 6
-- ATK 2500 | DEF 1200
-- Setcode: 72
--
-- Effect Text:
-- 6星怪兽×2
-- ①：1回合1次，把这张卡2个超量素材取除，以对方场上1只表侧表示怪兽和对方场上盖放的1张魔法·陷阱卡为对象才能发动。那些卡破坏。这个效果的发动后，直到回合结束时对方受到的战斗伤害变成一半。
--[[ __CARD_HEADER_END__ ]]

--No.72 ラインモンスター チャリオッツ・飛車
function c75253697.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,6,2)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75253697,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c75253697.descost)
	e1:SetTarget(c75253697.destg)
	e1:SetOperation(c75253697.desop)
	c:RegisterEffect(e1)
end
aux.xyz_number[75253697]=72
function c75253697.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,2,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c75253697.dfilter(c,pos)
	return c:IsPosition(pos)
end
function c75253697.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c75253697.dfilter,tp,0,LOCATION_MZONE,1,nil,POS_FACEUP)
		and Duel.IsExistingTarget(c75253697.dfilter,tp,0,LOCATION_SZONE,1,nil,POS_FACEDOWN) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectTarget(tp,c75253697.dfilter,tp,0,LOCATION_MZONE,1,1,nil,POS_FACEUP)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g2=Duel.SelectTarget(tp,c75253697.dfilter,tp,0,LOCATION_SZONE,1,1,nil,POS_FACEDOWN)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,2,0,0)
end
function c75253697.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg=g:Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()>0 then
		Duel.Destroy(tg,REASON_EFFECT)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(0,1)
	e1:SetValue(HALF_DAMAGE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
