--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 守墓的重炮手  (ID: 99877698)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 4
-- ATK 1400 | DEF 1200
-- Setcode: 46
--
-- Effect Text:
-- 每祭掉自己场上1只名称中含有「守墓」的怪兽，给与对方基本分700分的伤害。使用这个效果的场合不能使用「守墓的重炮手」作为祭品。
--[[ __CARD_HEADER_END__ ]]

--墓守の大筒持ち
function c99877698.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(99877698,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c99877698.cost)
	e1:SetTarget(c99877698.target)
	e1:SetOperation(c99877698.operation)
	c:RegisterEffect(e1)
end
function c99877698.costfilter(c)
	return c:IsSetCard(0x2e) and not c:IsCode(99877698)
end
function c99877698.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c99877698.costfilter,1,nil) end
	local sg=Duel.SelectReleaseGroup(tp,c99877698.costfilter,1,1,nil)
	Duel.Release(sg,REASON_COST)
end
function c99877698.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(700)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,700)
end
function c99877698.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
