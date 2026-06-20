--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 沙之赌徒  (ID: 50593156)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 3
-- ATK 300 | DEF 1600
--
-- Effect Text:
-- 进行3次投掷硬币。3次都是表的场合，对方场上怪兽全部破坏。3次都是里的场合，自己场上怪兽全部破坏。这个效果1回合只有1次在自己的主要阶段才能使用。
--[[ __CARD_HEADER_END__ ]]

--サンド・ギャンブラー
function c50593156.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(50593156,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c50593156.destg)
	e1:SetOperation(c50593156.desop)
	c:RegisterEffect(e1)
end
function c50593156.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,3)
end
function c50593156.desop(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2,c3=Duel.TossCoin(tp,3)
	if c1+c2+c3==3 then
		local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
		Duel.Destroy(g,REASON_EFFECT)
	elseif c1+c2+c3==0 then
		local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,nil)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
