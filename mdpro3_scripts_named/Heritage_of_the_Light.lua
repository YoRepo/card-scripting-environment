--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 光之继承  (ID: 48784854)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：和已在场上存在的怪兽相同种类（仪式·融合·同调·超量）的怪兽仪式·融合·同调·超量召唤的场合才能发动。自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--光の継承
function c48784854.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(48784854,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,48784854)
	e2:SetCondition(c48784854.drcon)
	e2:SetTarget(c48784854.drtg)
	e2:SetOperation(c48784854.drop)
	c:RegisterEffect(e2)
end
function c48784854.typfilter(c,sumtype)
	return c:IsFaceup() and c:GetType()&sumtype>0
end
function c48784854.cfilter(c,tp)
	local sumtype=bit.band(c:GetType(),TYPE_RITUAL|TYPE_FUSION|TYPE_SYNCHRO|TYPE_XYZ)
	return c:IsFaceup()
		and (c:IsSummonType(SUMMON_TYPE_RITUAL) or c:IsSummonType(SUMMON_TYPE_FUSION)
			or c:IsSummonType(SUMMON_TYPE_SYNCHRO) or c:IsSummonType(SUMMON_TYPE_XYZ))
		and Duel.IsExistingMatchingCard(c48784854.typfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,c,sumtype)
end
function c48784854.drcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c48784854.cfilter,1,nil,tp)
end
function c48784854.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c48784854.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
